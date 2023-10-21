//
//  CommunityPageView.swift
//  BeforeIn
//
//  Created by t2023-m0048 on 2023/10/20.
//

import UIKit
import SnapKit
import Then

class CommunityPageView: UIView {
    
    // MARK: - UI Properties
    
    private let profileImageView = UIImageView().then {
        $0.layer.cornerRadius = 30
        $0.clipsToBounds = true
        $0.backgroundColor = .lightGray
    }
    
    private let authorLabel = UILabel().then {
        $0.text = "닉네임"
        $0.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
    private let dateLabel = UILabel().then {
        $0.text = "10분 전"
        $0.font = UIFont.systemFont(ofSize: 18)
        $0.textColor = .systemGray2
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "제목제목제목제목제목"
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        $0.numberOfLines = 2
    }
    
    private let contentTextView = UITextView().then {
        $0.text = "내용내요앵ㄴ어ㅐ엉러ㅏㅇ라으ㅏㄹ아루아ㅜㄹ울우ㅏ루아ㅜ라우ㅏㄹ우루우라우ㅏ루아ㅜ라우라우ㅏ루아루ㅏ우라우ㅏ루아루ㅏ우어뤄우라ㅜ아ㅜ랑"
        // $0.backgroundColor = .systemGray6
        $0.font = UIFont.systemFont(ofSize: 17)
        $0.isEditable = false
    }
    
    private let likeButton = UIButton().then {
        $0.setImage(UIImage(systemName: "heart"), for: .normal)
        $0.tintColor = .black
    }
    
    private let likeLabel = UILabel().then {
        $0.text = "138"
        $0.font = UIFont.systemFont(ofSize: 15)
    }
    
    private let categoryButton = UIButton().then {
        $0.setTitle("우리끼리", for: .normal)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.backgroundColor = .BeforeInRed
        $0.layer.cornerRadius = 16.5
        $0.contentEdgeInsets = UIEdgeInsets(top: 5, left: 24, bottom: 5, right: 24)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    }
    
    private let divider = UIView().then {
        $0.backgroundColor = .systemGray6
    }
    
    private let commentLabel = UILabel().then {
        $0.text = "댓글"
        $0.font = UIFont.boldSystemFont(ofSize: 18)
    }
    
    let commentTableView = UITableView().then {
        $0.separatorStyle = .none
    }
    
    private let bottomDivider = UIView().then {
        $0.backgroundColor = .systemGray6
    }
    
    private let commentTextField = UITextField().then {
        $0.placeholder = "댓글을 입력해주세요."
        $0.borderStyle = .roundedRect
        $0.layer.cornerRadius = 15
        $0.layer.masksToBounds = true
        $0.backgroundColor = .systemGray6
    }
    
    private let sendButton = UIButton().then {
        $0.setTitle("등록", for: .normal)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.backgroundColor = .BeforeInRed
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        $0.layer.cornerRadius = 16.5
    }

    
    // MARK: - Life Cycle
    override init(frame: CGRect){
        super.init(frame: frame)
        addSubview()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Methods
    func addSubview(){
        addSubview(profileImageView)
        addSubview(authorLabel)
        addSubview(dateLabel)
        addSubview(titleLabel)
        addSubview(contentTextView)
        addSubview(likeButton)
        addSubview(likeLabel)
        addSubview(categoryButton)
        addSubview(divider)
        addSubview(commentLabel)
        addSubview(commentTableView)
        addSubview(bottomDivider)
        addSubview(commentTextField)
        addSubview(sendButton)
    }
    
    
    func setUI(){
        profileImageView.snp.makeConstraints {
            $0.top.equalTo(self.snp.top).offset(124)
            $0.left.equalTo(self.snp.left).offset(16)
            $0.height.width.equalTo(60)
        }
        
        authorLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.top)
            $0.left.equalTo(profileImageView.snp.right).offset(8)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(authorLabel.snp.bottom).offset(0) // 안먹힘??
            $0.left.equalTo(authorLabel.snp.left)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(32)
            $0.left.right.equalTo(self).inset(16)
        }
        
        contentTextView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.left.right.equalTo(self).inset(10)
            $0.height.equalTo(200)
        }
        
        likeButton.snp.makeConstraints {
            $0.right.equalTo(self.snp.right).offset(-50)
            $0.bottom.equalTo(contentTextView.snp.bottom).offset(24)
        }
        
        likeLabel.snp.makeConstraints {
            $0.left.equalTo(likeButton.snp.right).offset(5)
            $0.right.equalTo(self.snp.right).offset(-8)
            $0.bottom.equalTo(contentTextView.snp.bottom).offset(21)
        }
        
        categoryButton.snp.makeConstraints {
            $0.left.equalTo(self.snp.left).offset(16)
            $0.bottom.equalTo(contentTextView.snp.bottom).offset(24)
        }
        
        divider.snp.makeConstraints {
            $0.top.equalTo(categoryButton.snp.bottom).offset(24)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(3)
        }
        
        commentLabel.snp.makeConstraints {
            $0.top.equalTo(divider.snp.bottom).offset(16)
            $0.left.equalTo(self).offset(16)
        }
        
        commentTableView.snp.makeConstraints {
            $0.top.equalTo(commentLabel.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(160)
        }
        
        bottomDivider.snp.makeConstraints {
            $0.top.equalTo(commentTableView.snp.bottom).offset(8)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(3)
        }
        
        commentTextField.snp.makeConstraints {
            $0.top.equalTo(bottomDivider.snp.bottom).offset(8)
            $0.left.equalTo(self).offset(16)
            $0.bottom.equalTo(self.safeAreaLayoutGuide)
            $0.right.equalTo(sendButton.snp.left).offset(-8)
        }
        
        sendButton.snp.makeConstraints {
            $0.centerY.equalTo(commentTextField.snp.centerY)
            $0.left.equalTo(commentTextField.snp.right).offset(8)
            $0.right.equalTo(self).offset(-16)
            $0.bottom.equalTo(self.safeAreaLayoutGuide)
            $0.width.equalTo(60)
        }
        
        
    }
    
    
}
