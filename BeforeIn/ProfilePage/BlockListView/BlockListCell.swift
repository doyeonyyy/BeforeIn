//
//  BlockListCell.swift
//  BeforeIn
//
//  Created by t2023-m0048 on 2023/11/09.
//

import UIKit

class BlockListCell: UITableViewCell {
    // MARK: - UI Properties
    let nameLabel = UILabel().then {
        $0.numberOfLines = 0
    }
    
    lazy var unblockButton = UIButton().then {
        $0.setTitle("해제", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 10)
        $0.backgroundColor = .BeforeInRed
        $0.layer.cornerRadius = 12
        $0.layer.masksToBounds = true
        $0.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
    }
    
    var onRelease: (() -> Void)?
    
    // MARK: - Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Function
    func setUI(){
        contentView.addSubview(nameLabel)
        contentView.addSubview(unblockButton)
        
        nameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.lessThanOrEqualTo(unblockButton.snp.left).offset(-5)
            make.centerY.equalTo(contentView)
        }
        
        unblockButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.centerY.equalTo(contentView)
        }
        
        unblockButton.addTarget(self, action: #selector(releaseButtonTapped), for: .touchUpInside)
    }
    
    
    // MARK: - @objc
    @objc func releaseButtonTapped() {
        onRelease?()

    }
    
    func configure(with user: String, onRelease: @escaping () -> Void) {
        nameLabel.text = user
        self.onRelease = onRelease

    }
    
    
}

