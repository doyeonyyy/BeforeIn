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
//    private let profileImageView = UIImageView().then {
//        $0.layer.cornerRadius = 30
//        $0.clipsToBounds = true
//        $0.backgroundColor = .lightGray
//    }
    
    private let scrollView = UIScrollView().then {
        $0.alwaysBounceVertical = true
        $0.showsVerticalScrollIndicator = false
    }
    
    private let contentView: UIView = {
        let view = UIView()
        return view
    }()

    let moreButton = UIButton().then {
        $0.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        $0.tintColor = .systemGray
        $0.transform = CGAffineTransform(rotationAngle: .pi / 2) // 세로로 뒤집기
        $0.isUserInteractionEnabled = true
        $0.imageView?.contentMode = .scaleAspectFit
    }
    
    let blockButton = UIButton().then {
        $0.setTitle("차단", for: .normal)
        $0.setTitleColor(UIColor.black, for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
    }
    
    private let authorLabel = UILabel().then {
        $0.text = "닉네임"
        $0.font = UIFont.systemFont(ofSize: 14)
    }
    
    private let dateLabel = UILabel().then {
        $0.text = "10분 전"
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.textColor = .systemGray2
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "제목"
        $0.font = UIFont.boldSystemFont(ofSize: 18)
        $0.numberOfLines = 2
    }
    
    let contentTextView = UITextView().then {
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
//        addSubview(profileImageView)
        
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(moreButton)
        contentView.addSubview(blockButton)
        contentView.addSubview(authorLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(contentTextView)
//        addSubview(likeButton)
//        addSubview(likeLabel)
        contentView.addSubview(reportButton)
        contentView.addSubview(categoryButton)
        contentView.addSubview(divider)
        contentView.addSubview(commentLabel)
        contentView.addSubview(commentTableView)
       addSubview(commentTextField)
       addSubview(sendButton)
    }
    
    
    func setUI(){
//        profileImageView.snp.makeConstraints {
//            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top)
//            $0.left.equalTo(self.snp.left).offset(16)
//            $0.height.width.equalTo(60)
//        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalTo(self)
            $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
        }
        
        contentView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview().offset(16)
            $0.right.equalTo(moreButton.snp.left).offset(-5)
            $0.height.equalTo(48)
        }
        
        authorLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(2)
            $0.left.equalToSuperview().offset(16)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.left.equalTo(authorLabel.snp.right).offset(7)
        }
        
        moreButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.right.equalToSuperview().offset(-16)
            $0.height.width.equalTo(15)
        }
        
        blockButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.right.equalToSuperview().offset(-16)
        }

        contentTextView.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(10)
            $0.left.right.equalToSuperview().inset(12)
            $0.height.equalTo(220)
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
            $0.right.equalToSuperview().offset(-40)
            $0.top.equalTo(contentTextView.snp.bottom).offset(8)
        }
        
        categoryButton.snp.makeConstraints {
            $0.top.equalTo(contentTextView.snp.bottom).offset(10)
            $0.left.equalToSuperview().offset(16)
        }
        
        divider.snp.makeConstraints {
            $0.top.equalTo(categoryButton.snp.bottom).offset(10)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        commentLabel.snp.makeConstraints {
            $0.top.equalTo(divider.snp.bottom).offset(8)
            $0.left.equalToSuperview().offset(16)
        }
        
        commentTableView.snp.makeConstraints {
            $0.top.equalTo(commentLabel.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(contentView.snp.bottom)
            $0.height.equalTo(200)
        }
        
        commentTextField.snp.makeConstraints {
            $0.left.equalTo(self.safeAreaLayoutGuide).offset(16)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-5)
            $0.right.equalTo(sendButton.snp.left).offset(-8)
        }
        
        sendButton.snp.makeConstraints {
            $0.left.equalTo(commentTextField.snp.right).offset(8)
            $0.right.equalTo(self.safeAreaLayoutGuide).offset(-16)
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
            moreButton.isHidden = false
            
            blockButton.isHidden = true
            reportButton.isHidden = true
        } else {
            moreButton.isHidden = true
            
            blockButton.isHidden = false
            reportButton.isHidden = false
        }
       
        print("커뮤니티 디테일view 업데이트")
    }
    
//    
//    func updateTextViewHeight() {
//        let fixedWidth = contentTextView.frame.size.width
//        let newSize = contentTextView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
//        contentTextView.snp.updateConstraints { make in
//            make.height.greaterThanOrEqualTo( max(220, newSize.height) )
//        }
//        self.layoutIfNeeded()
//    }

    
}
