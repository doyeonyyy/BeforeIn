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
        $0.text = "안녕"
        $0.textColor = .white
        $0.font = UIFont.boldSystemFont(ofSize: 18)
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
        contentView.backgroundColor = .black // 이미지로 변경할 때 수정해야할 부분
        contentView.addSubview(spaceLabe)
        spaceLabe.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
