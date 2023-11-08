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
        $0.text = ""
        $0.font = UIFont.boldSystemFont(ofSize: 15)
    }
    
    let dateLabel = UILabel().then {
        $0.text = ""
        $0.textColor = .systemGray2
        $0.font = UIFont.systemFont(ofSize: 13)
    }
    
    let editButton = UIButton().then {
        $0.setImage(UIImage(systemName: "pencil.circle"), for: .normal)
        $0.tintColor = .systemGray
    }
    
    let deleteButton = UIButton().then {
        $0.setImage(UIImage(systemName: "xmark.circle"), for: .normal)
        $0.tintColor = .systemGray
    }
    
    let reportButton = UIButton().then {
//        $0.setImage(UIImage(systemName: "light.beacon.max.fill"), for: .normal)
//        $0.tintColor = .black
        $0.setTitle("신고", for: .normal)
        $0.setTitleColor(.systemGray, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 12)
    }
    
    let commentLabel = UILabel().then {
        $0.text = "댓글"
        $0.font = UIFont.systemFont(ofSize: 16)
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
        contentView.addSubview(editButton)
        contentView.addSubview(deleteButton)
        contentView.addSubview(reportButton)
        contentView.addSubview(commentLabel)
    }
    
    func setCell(){
        profileImageView.snp.makeConstraints {
            $0.centerY.equalTo(contentView.snp.centerY)
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
        
        editButton.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.top)
            $0.right.equalTo(deleteButton.snp.left).offset(-3)
        }
        
        deleteButton.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.top)
            $0.right.equalTo(contentView.snp.right).offset(-16)
        }
        
        reportButton.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.top)
            $0.right.equalTo(contentView.snp.right).offset(-16)
        }
        
        commentLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(5)
            $0.left.equalTo(profileImageView.snp.right).offset(8)
            $0.bottom.equalTo(contentView.snp.bottom).offset(-8)
        }
    }
    


}



