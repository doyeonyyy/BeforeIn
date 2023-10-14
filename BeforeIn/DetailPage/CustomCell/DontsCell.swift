//
//  DontsCell.swift
//  BeforeIn
//
//  Created by Sanghun K. on 10/14/23.
//

import UIKit

class DontsCell: UICollectionViewCell {
    
    // MARK: - Properties
    var backgroundImage = UIImageView().then {
        $0.backgroundColor = .gray
    }
    
    var titleLabel = UILabel().then {
        $0.text = "타이틀"
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    }
    
    var descriptionLabel = UILabel().then {
        $0.text = "설명"
        $0.textColor = .white
        $0.numberOfLines = 0
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
        contentView.clipsToBounds = true
        
        // addSubview
        contentView.addSubview(backgroundImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        
        // makeConstraints
        backgroundImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.bottom.equalTo(descriptionLabel.snp.top).offset(-10)
        }
        descriptionLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.bottom.equalToSuperview().offset(-21)
        }
        
    }
}
