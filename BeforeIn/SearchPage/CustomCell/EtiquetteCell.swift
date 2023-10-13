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
    var image = UIImageView().then {
        $0.image = UIImage(systemName: "photo.fill")
        $0.tintColor = .gray
    }
    
    var stackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 8
        $0.alignment = .leading
        $0.distribution = .fill
    }
    
    var titleLabel = UILabel().then {
        $0.text = "타이틀"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 20, weight: .medium)
    }
    
    var descriptionLabel = UILabel().then {
        $0.text = "설명"
        $0.textColor = .black
        $0.numberOfLines = 2
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
       
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
        contentView.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
        contentView.layer.cornerRadius = 8
        
        
        // addSubview
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        
        contentView.addSubview(image)
        contentView.addSubview(stackView)
        
        // makeConstraints
        image.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(24)
            $0.width.equalTo(80)
            $0.height.equalTo(80)
        }
        stackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(image.snp.trailing).offset(24)
            $0.trailing.equalToSuperview().offset(-24)
        }
        
    }
   
}
    
    
