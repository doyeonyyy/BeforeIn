//
//  CategoryCell.swift
//  BeforeIn
//
//  Created by Sanghun K. on 10/28/23.
//

import UIKit
import SnapKit
import Then

class CategoryCell: UICollectionViewCell {
    
    var categoryLabel = UILabel().then{
        $0.text = "카테고리 레이블"
        $0.textColor = .BeforeInRed
        $0.font = UIFont.boldSystemFont(ofSize: 18)
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                contentView.backgroundColor = .BeforeInRed
                categoryLabel.textColor = .white
            } else {
                contentView.backgroundColor = .clear
                categoryLabel.textColor = .BeforeInRed
            }
        }
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
        contentView.addSubview(categoryLabel)
    }
    
    private func setupConstraint() {
        categoryLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
