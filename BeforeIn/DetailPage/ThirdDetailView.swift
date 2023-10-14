//
//  ThirdDetailView.swift
//  BeforeIn
//
//  Created by t2023-m0048 on 2023/10/13.
//

import UIKit
import SnapKit
import Then

class ThirdDetailView: UIView {
    
    // MARK: - UI Properties
    lazy var detailImageView = UIView().then {
        $0.backgroundColor = .white
    }
    
    lazy var titleEmoji = UILabel().then {
        $0.text = "👍"
        $0.font = .systemFont(ofSize: 32)
        $0.textColor = .black
        $0.numberOfLines = 0
    }
    
    lazy var titleLabel = UILabel().then {
        $0.text = "이것만 지켜도 Good"
        $0.font = .systemFont(ofSize: 22, weight: .black)
        $0.textColor = .black
        $0.numberOfLines = 0
    }
    
    lazy var descriptionLabel = UILabel().then {
        $0.text = """
        당신의 사소한 배려가 결혼식의 행복을
        더해줍니다.
        """
        $0.font = .systemFont(ofSize: 16)
        $0.textColor = .black
        $0.numberOfLines = 0
    }
    
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
    
    lazy var dosCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).then {
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
        addSubview(detailImageView)
        addSubview(titleEmoji)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(beforeInButton)
        addSubview(afterInButton)
        addSubview(beforeOutButton)
        addSubview(dosCollectionView)

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
        dosCollectionView.snp.makeConstraints {
            $0.top.equalTo(beforeInButton.snp.bottom).offset(19)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(422)
        }
    }
    
}

