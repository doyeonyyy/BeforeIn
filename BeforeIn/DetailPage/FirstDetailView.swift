//
//  FirstDetailView.swift
//  BeforeIn
//
//  Created by t2023-m0048 on 2023/10/13.
//

import UIKit
import SnapKit
import Then

class FirstDetailView: UIView {
    
    // MARK: - UI Properties
    lazy var detailImageView = UIView().then {
        $0.backgroundColor = .darkGray
    }
    
    lazy var backButton = UIButton().then {
        $0.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        $0.tintColor = .white
    }
    
    lazy var titleLabel = UILabel().then {
        $0.text = "결혼식장 에티켓 알아보기"
        $0.font = .boldSystemFont(ofSize: 32)
        $0.textColor = .white
    }
    
    lazy var descriptionLabel = UILabel().then {
        $0.text = "결혼식장 방문에서 지켜야할 기본 규칙을 알아봅시다"
        $0.font = .systemFont(ofSize: 16)
        $0.textColor = .white
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
        addSubview(backButton)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        
    }
    
    func setUI(){
        detailImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        backButton.snp.makeConstraints {
            $0.top.equalTo(detailImageView.snp.top).offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.width.height.equalTo(34)
        }
        
        titleLabel.snp.makeConstraints {
            $0.bottom.equalTo(descriptionLabel.snp.top).offset(-8)
            $0.leading.equalToSuperview().offset(16)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-88)
            $0.leading.equalToSuperview().offset(16)
        }
    }
    
}

