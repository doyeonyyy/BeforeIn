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
        $0.font = UIFont.boldSystemFont(ofSize: 18)
    }
    
    var imageView = UIImageView().then{
        $0.image = UIImage(systemName: "person.fill")
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
        spaceLabe.text = etiquette.place
    }
}
