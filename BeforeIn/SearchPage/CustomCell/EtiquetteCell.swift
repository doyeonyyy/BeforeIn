//
//  EtiquetteCell.swift
//  BeforeIn
//
//  Created by Sanghun K. on 10/12/23.
//

import SnapKit
import Then
import UIKit

class EtiquetteCell: UICollectionViewCell {
    
    // MARK: - Properties
    var imageView = UIImageView().then {
        $0.backgroundColor = .gray
    }
    
    var stackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 8
        $0.alignment = .leading
        $0.distribution = .fill
    }
    
    var titleLabel = UILabel().then {
        $0.text = "타이틀"
//        $0.textColor = .black
        $0.font = UIFont(name: "SUITE-Bold", size: 18)
    }
    
    var descriptionLabel = UILabel().then {
        $0.text = "설명"
//        $0.textColor = .black
        $0.numberOfLines = 2
        $0.font = UIFont(name: "SUITE-Regular", size: 14)
       
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        contentView.layer.borderWidth = 0.5
        contentView.layer.borderColor = UIColor.systemGray5.cgColor
    }
    
    private func setupUI() {
//        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 8
        contentView.layer.borderWidth = 0.5
        contentView.clipsToBounds = true
        contentView.layer.borderColor = UIColor.systemGray5.cgColor
//        contentView.layer.shadowColor = UIColor.black.cgColor
//        contentView.layer.shadowOpacity = 0.1
//        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
//        contentView.layer.shadowRadius = 4
//        contentView.layer.masksToBounds = false
//        
//        imageView.layer.cornerRadius = 8
//        imageView.layer.masksToBounds = true
        
        // addSubview
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        
        contentView.addSubview(imageView)
        contentView.addSubview(stackView)
        
        // makeConstraints
        imageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.width.equalTo(116)
            $0.height.equalTo(116)
        }
        stackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(imageView.snp.trailing).offset(20)
            $0.trailing.equalToSuperview().offset(-24)
        }
        
    }
   
}
    
    
