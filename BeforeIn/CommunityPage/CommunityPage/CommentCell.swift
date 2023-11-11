//
//  CommentCell.swift
//  BeforeIn
//
//  Created by t2023-m0048 on 2023/10/20.
//

import UIKit

class CommentCell: UITableViewCell {
    
    // MARK: - UI Properties
//    let profileImageView = UIImageView().then {
//        $0.layer.cornerRadius = 20
//        $0.clipsToBounds = true
//        $0.backgroundColor = .lightGray
//    }
    
    let authorLabel = UILabel().then {
        $0.text = ""
        $0.font = UIFont.systemFont(ofSize: 14)
    }
    
    let dateLabel = UILabel().then {
        $0.text = ""
        $0.textColor = .systemGray2
        $0.font = UIFont.systemFont(ofSize: 12)
    }
    
    let moreButton = UIButton().then {
        $0.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        $0.tintColor = .systemGray
        $0.transform = CGAffineTransform(rotationAngle: .pi / 2) // 세로로 뒤집기
        $0.isUserInteractionEnabled = true
        $0.imageView?.contentMode = .scaleAspectFit
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
        $0.font = UIFont.systemFont(ofSize: 15)
        $0.numberOfLines = 0
        $0.textAlignment = .natural
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
        
//        contentView.addSubview(profileImageView)
        contentView.addSubview(authorLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(moreButton)
        contentView.addSubview(reportButton)
        contentView.addSubview(commentLabel)
    }
    
    func setCell(){
//        profileImageView.snp.makeConstraints {
//            $0.centerY.equalTo(contentView.snp.centerY)
//            $0.left.equalTo(contentView.snp.left).offset(16)
//            $0.width.height.equalTo(40)
//        }
        
        authorLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(5)
            $0.left.equalToSuperview().offset(20)
        }
        
        dateLabel.snp.makeConstraints {
            $0.centerY.equalTo(authorLabel.snp.centerY)
            $0.left.equalTo(authorLabel.snp.right).offset(6)
        }

        moreButton.snp.makeConstraints {
            $0.top.equalTo(authorLabel.snp.top).offset(5)
            $0.right.equalTo(contentView.snp.right).offset(-20)
            $0.height.width.equalTo(10)
        }
        
        reportButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(5)
            $0.right.equalTo(contentView.snp.right).offset(-20)
        }
        
        commentLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(10)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().inset(20)
            $0.bottom.equalTo(contentView.snp.bottom).offset(-8)
        }
    }
    


}



