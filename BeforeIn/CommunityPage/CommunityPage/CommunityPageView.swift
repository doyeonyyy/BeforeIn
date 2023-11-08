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
    
    let editButton = UIButton().then {
        $0.setTitle("수정", for: .normal)
        $0.setTitleColor(UIColor.black, for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
    }
    
    let deleteButton = UIButton().then {
        $0.setTitle("삭제", for: .normal)
        $0.setTitleColor(UIColor.black, for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
    }
    
    let blockButton = UIButton().then {
        $0.setTitle("차단", for: .normal)
        $0.setTitleColor(UIColor.black, for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
    }
    
    private let authorLabel = UILabel().then {
        $0.text = "닉네임"
        $0.font = UIFont.boldSystemFont(ofSize: 16)
    }
    
    private let dateLabel = UILabel().then {
        $0.text = "10분 전"
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textColor = .systemGray2
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "제목"
        $0.font = UIFont.boldSystemFont(ofSize: 18)
        $0.numberOfLines = 2
    }
    
    private let contentTextView = UITextView().then {
        $0.text = "내용"
//        $0.backgroundColor = .systemGray6
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.isEditable = false
        $0.isSelectable = false
    }
    
//    private let likeButton = UIButton().then {
//        $0.setImage(UIImage(systemName: "heart"), for: .normal)
//        $0.tintColor = .black
//    }
//    
//    private let likeLabel = UILabel().then {
//        $0.text = "138"
//        $0.font = UIFont.systemFont(ofSize: 15)
//    }
    
    let reportButton = UIButton().then {
        $0.setImage(UIImage(systemName: "light.beacon.max.fill"), for: .normal)
        $0.setTitle(" 신고", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        $0.sizeToFit()
    }
    
//    private let reportLabel = UILabel().then {
//        $0.text = "신고"
//        $0.font = UIFont.systemFont(ofSize: 14)
//    }
//    
    private let categoryButton = UIButton().then {
        $0.setTitle("", for: .normal)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.backgroundColor = .BeforeInRed
        $0.layer.cornerRadius = 5
        $0.contentEdgeInsets = UIEdgeInsets(top: 4, left: 14, bottom: 4, right: 14)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
    }
    
    private let divider = UIView().then {
        $0.backgroundColor = .systemGray6
    }
    
    private let commentLabel = UILabel().then {
        $0.text = "댓글"
        $0.font = UIFont.boldSystemFont(ofSize: 17)
    }
    
    let commentTableView = UITableView().then {
        $0.separatorStyle = .none
    }
    
    let commentTextField = UITextField().then {
        $0.placeholder = "댓글을 입력해주세요."
        $0.borderStyle = .roundedRect
        $0.layer.cornerRadius = 15
        $0.layer.masksToBounds = true
        $0.backgroundColor = .systemGray6
    }
    
    let sendButton = UIButton().then {
        $0.setTitle("등록", for: .normal)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.backgroundColor = .BeforeInRed
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        $0.layer.cornerRadius = 16.5
    }
    
    var communityPageViewModel: CommunityPageViewModel? {
        didSet {
            communityPageViewModel?.updateView = { [weak self] in
                self?.updateView()
            }
            updateView()
        }
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
        addSubview(editButton)
        addSubview(blockButton)
        addSubview(deleteButton)
        addSubview(authorLabel)
        addSubview(dateLabel)
        addSubview(titleLabel)
        addSubview(contentTextView)
//        addSubview(likeButton)
//        addSubview(likeLabel)
        addSubview(reportButton)
        addSubview(categoryButton)
        addSubview(divider)
        addSubview(commentLabel)
        addSubview(commentTableView)
        addSubview(commentTextField)
        addSubview(sendButton)
    }
    
    
    func setUI(){
        profileImageView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            $0.left.equalTo(self.snp.left).offset(16)
            $0.height.width.equalTo(60)
        }
        
        editButton.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            $0.right.equalTo(deleteButton.snp.left).offset(5)
        }
        
        deleteButton.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            $0.right.equalTo(self.snp.right).offset(-10)
        }
        
        blockButton.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            $0.right.equalTo(self.snp.right).offset(-16)
        }
        
        authorLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(5)
            $0.left.equalTo(profileImageView.snp.right).offset(8)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(authorLabel.snp.bottom).offset(5)
            $0.left.equalTo(authorLabel.snp.left)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom)
            $0.left.right.equalTo(self).inset(16)
            $0.height.equalTo(48)
        }
        
        contentTextView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.left.right.equalTo(self).inset(12)
            $0.height.equalTo(200)
        }
        
//        likeButton.snp.makeConstraints {
//            $0.right.equalTo(self.snp.right).offset(-40)
//            $0.top.equalTo(contentTextView.snp.bottom).offset(8)
//        }
//        
//        likeLabel.snp.makeConstraints {
//            $0.left.equalTo(likeButton.snp.right).offset(5)
//            $0.right.equalTo(self.snp.right).offset(-3)
//            $0.top.equalTo(contentTextView.snp.bottom).offset(10)
//        }
        reportButton.snp.makeConstraints {
            $0.right.equalTo(self.snp.right).offset(-40)
            $0.top.equalTo(contentTextView.snp.bottom).offset(8)
        }
        
        categoryButton.snp.makeConstraints {
            $0.top.equalTo(contentTextView.snp.bottom).offset(10)
            $0.left.equalTo(self.snp.left).offset(16)
        }
        
        divider.snp.makeConstraints {
            $0.top.equalTo(categoryButton.snp.bottom).offset(10)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        commentLabel.snp.makeConstraints {
            $0.top.equalTo(divider.snp.bottom).offset(8)
            $0.left.equalTo(self).offset(16)
        }
        
        commentTableView.snp.makeConstraints {
            $0.top.equalTo(commentLabel.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(commentTextField.snp.top)
        }
        
        commentTextField.snp.makeConstraints {
            $0.top.equalTo(commentTableView.snp.bottom).offset(8)
            $0.left.equalTo(self).offset(16)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-5)
            $0.right.equalTo(sendButton.snp.left).offset(-8)
        }
        
        sendButton.snp.makeConstraints {
            $0.centerY.equalTo(commentTextField.snp.centerY)
            $0.left.equalTo(commentTextField.snp.right).offset(8)
            $0.right.equalTo(self).offset(-16)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-5)
            $0.width.equalTo(40)
        }
        
        
    }
    
    private func updateView() {
        titleLabel.text = communityPageViewModel?.title
        contentTextView.text = communityPageViewModel?.content
        authorLabel.text = communityPageViewModel?.nickname
        dateLabel.text = communityPageViewModel?.postingTime
        categoryButton.setTitle(communityPageViewModel?.category, for: .normal)
//        likeLabel.text = communityPageViewModel?.likes
        
        if currentUser.email == communityPageViewModel?.writerEmail {
            // 수정 삭제
            editButton.isHidden = false
            deleteButton.isHidden = false
            
            blockButton.isHidden = true
            reportButton.isHidden = true
        } else {
            // 차단, 신고버튼
            editButton.isHidden = true
            deleteButton.isHidden = true
            
            blockButton.isHidden = false
            reportButton.isHidden = false
        }

       
        print("커뮤니티 디테일view 업데이트")
    }
    
    
}
