//
//  CommentCell.swift
//  BeforeIn
//
//  Created by t2023-m0048 on 2023/10/20.
//

import UIKit

class CommentCell: UITableViewCell {
    
    // MARK: - UI Properties
    let profileImageView = UIImageView().then {
        $0.layer.cornerRadius = 20
        $0.clipsToBounds = true
        $0.backgroundColor = .lightGray
    }
    
    let authorLabel = UILabel().then {
        $0.text = "닉네임"
        $0.font = UIFont.boldSystemFont(ofSize: 16)
    }
    
    let dateLabel = UILabel().then {
        $0.text = "10분 전"
        $0.font = UIFont.systemFont(ofSize: 14)
    }
    
    let deleteButton = UIButton().then {
        $0.setImage(UIImage(systemName: "xmark.circle"), for: .normal)
        $0.tintColor = .black
    }
    
    let commentLabel = UILabel().then {
        $0.text = "댓글"
    }
    
    
    // MARK: - Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        addSubview()
        setCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Methods
    func addSubview(){
        self.selectionStyle = .none
        
        contentView.addSubview(profileImageView)
        contentView.addSubview(authorLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(deleteButton)
        contentView.addSubview(commentLabel)
    }
    
    
    func setCell(){
        profileImageView.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top).offset(16)
            $0.left.equalTo(contentView.snp.left).offset(16)
            $0.width.height.equalTo(40)
        }
        
        authorLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.top)
            $0.left.equalTo(profileImageView.snp.right).offset(8)
        }
        
        dateLabel.snp.makeConstraints {
            $0.left.equalTo(authorLabel.snp.right).offset(4)
            $0.bottom.equalTo(authorLabel.snp.bottom)
        }
        
        deleteButton.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.top)
            $0.right.equalTo(contentView.snp.right).offset(-16)
        }
        
        commentLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(8)
            $0.left.equalTo(profileImageView.snp.right).offset(8)
            $0.bottom.equalTo(contentView.snp.bottom).offset(-8)
        }
    }
}
