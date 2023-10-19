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
    
    lazy var etiquetteCountLabel = UILabel().then {
        $0.text = "1"
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = .beforeInRed
    }
    
    lazy var etiquetteTotalCountLabel = UILabel().then {
        $0.text = "(total)"
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = .darkGray
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
        addSubview(etiquetteCountLabel)
        addSubview(etiquetteTotalCountLabel)
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
        etiquetteCountLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(48)
            $0.trailing.equalTo(etiquetteTotalCountLabel.snp.leading).offset(0)
        }
        etiquetteTotalCountLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(48)
            $0.trailing.equalToSuperview().offset(-24)
        }
        dontsCollectionView.snp.makeConstraints {
            $0.top.equalTo(etiquetteTotalCountLabel.snp.bottom).offset(19)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(422)
        }
    }
    
}

