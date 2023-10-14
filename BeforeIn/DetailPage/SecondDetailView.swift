//
//  SecondDetailView.swift
//  BeforeIn
//
//  Created by t2023-m0048 on 2023/10/13.
//

import UIKit
import SnapKit
import Then

class SecondDetailView: UIView {
    
    // MARK: - UI Properties
    lazy var detailImageView = UIView().then {
        $0.backgroundColor = .white
    }
    
    lazy var titleEmoji = UILabel().then {
        $0.text = "🚨"
        $0.font = .systemFont(ofSize: 32)
        $0.textColor = .black
        $0.numberOfLines = 0
    }
    
    lazy var titleLabel = UILabel().then {
        $0.text = "이것만은 절대 금지!!"
        $0.font = .systemFont(ofSize: 22, weight: .black)
        $0.textColor = .black
        $0.numberOfLines = 0
    }
    
    lazy var descriptionLabel = UILabel().then {
        $0.text = """
        세상에서 한번 뿐인 행복한 날
        모두를 위해서 피해야하는 언행을 모았습니다.
        """
        $0.font = .systemFont(ofSize: 16)
        $0.textColor = .black
        $0.numberOfLines = 0
    }
    
    // TODO: - 궁금한점: 결혼식, 장례식 등이 아닌 경우에는 이 버튼들은 안보이게 하는건지..?_?
    lazy var beforeInButton = UIButton().then {
        $0.setTitle("들어가기 전", for: .normal)
        $0.setTitleColor(.lightGray, for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        $0.backgroundColor = .none
    }
    
    lazy var afterInButton = UIButton().then {
        $0.setTitle("들어가서", for: .normal)
        $0.setTitleColor(.lightGray, for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        $0.backgroundColor = .none
    }
    
    lazy var beforeOutButton = UIButton().then {
        $0.setTitle("나오면서", for: .normal)
        $0.setTitleColor(.lightGray, for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        $0.backgroundColor = .none
    }
    
    let layout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = 16
        $0.itemSize = CGSize(width: 332, height: 422)
    }

    lazy var dontsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .clear
        $0.showsHorizontalScrollIndicator = false
        $0.contentInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 0)
        
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
    
    
    func addSubview() {
        addSubview(detailImageView)
        addSubview(titleEmoji)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(beforeInButton)
        addSubview(afterInButton)
        addSubview(beforeOutButton)
        addSubview(dontsCollectionView)
    }
    
    func setUI(){
        detailImageView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        titleEmoji.snp.makeConstraints {
            $0.top.equalToSuperview().offset(86)
            $0.leading.equalToSuperview().offset(24)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(titleEmoji.snp.bottom).offset(5)
            $0.leading.equalToSuperview().offset(24)
        }
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(24)
        }
        beforeInButton.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(48)
            $0.leading.equalToSuperview().offset(24)
        }
        afterInButton.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(48)
            $0.leading.equalTo(beforeInButton.snp.trailing).offset(32)
        }
        beforeOutButton.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(48)
            $0.leading.equalTo(afterInButton.snp.trailing).offset(32)
        }
        dontsCollectionView.snp.makeConstraints {
            $0.top.equalTo(beforeInButton.snp.bottom).offset(19)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(422)
        }
    }
    
}

