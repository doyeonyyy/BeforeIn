//
//  TagCell.swift
//  BeforeIn
//
//  Created by t2023-m079 on 10/21/23.
//

import UIKit
import Then
import SnapKit

class TagCell: UICollectionViewCell {
    
    var tagLabel = UILabel().then{
        $0.text = "태그 레이블"
        $0.textColor = .BeforeInRed
        $0.font = UIFont.boldSystemFont(ofSize: 18)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError()
    }
    
    private func setupUI() {
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.BeforeInRed?.cgColor
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 16.5
        contentView.addSubview(tagLabel)
    }
    
    private func setupConstraint() {
        tagLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
