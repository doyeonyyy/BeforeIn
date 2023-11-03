//
//  RecentItemCell.swift
//  BeforeIn
//
//  Created by t2023-m079 on 10/12/23.
//

import UIKit
import Then
import SnapKit

class RecentItemCell: UICollectionViewCell {
    
    var spaceLabe = UILabel().then{
        $0.text = "장소이름"
        $0.textColor = .white
        $0.font = UIFont.boldSystemFont(ofSize: 14)
    }
    
    var imageView = UIImageView().then{
        $0.image = UIImage(systemName: "person.fill")
        $0.contentMode = .scaleAspectFill
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        contentView.layer.cornerRadius = contentView.frame.width / 2
        contentView.clipsToBounds = true
        contentView.addSubview(imageView)
        contentView.addSubview(spaceLabe)
        
        imageView.snp.makeConstraints { make in
            make.width.height.equalToSuperview()
        }
        spaceLabe.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
    }
    
    func configureUI(_ etiquette: Etiquette) {
        imageView.image = etiquette.mainImage
        applyMask(to: imageView, withAlpha: 0.4)
        
        spaceLabe.text = etiquette.place
    }
    
    func applyMask(to imageView: UIImageView, withAlpha alpha: CGFloat) {
        if let image = imageView.image, let cgImage = image.cgImage {
            let width = cgImage.width
            let height = cgImage.height
            let bitsPerComponent = 8
            let bytesPerRow = 4 * width
            let colorSpace = CGColorSpaceCreateDeviceRGB()
            let bitmapInfo: CGBitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)

            if let context = CGContext(data: nil, width: width, height: height, bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo.rawValue) {
                context.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
                context.clip(to: CGRect(x: 0, y: 0, width: width, height: height))
                context.setFillColor(UIColor(white: 0, alpha: alpha).cgColor)
                context.fill(CGRect(x: 0, y: 0, width: width, height: height))

                if let maskedImage = context.makeImage() {
                    imageView.image = UIImage(cgImage: maskedImage)
                }
            }
        }
    }
        
}
