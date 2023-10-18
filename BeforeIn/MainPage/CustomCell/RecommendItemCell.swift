//
//  RecommendItemCell.swift
//  BeforeIn
//
//  Created by t2023-m079 on 10/12/23.
//

import UIKit
import SnapKit
import Then

class RecommendItemCell: UICollectionViewCell {
    
    var contentImageView = UIImageView().then {
        $0.backgroundColor = .black
    }
    var mainLabel = UILabel().then {
        $0.text = "소개팅 꿀팁 에티켓"
        $0.font = UIFont.boldSystemFont(ofSize: 18)
    }
    var contentLabel = UILabel().then {
        $0.text = "\"너가 그래서 솔로\"...이것만 알면 너도 올해는 커플!"
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textColor = .systemGray
        $0.numberOfLines = 0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    func configureUI(_ etiquette: Etiquette) {
        contentImageView.image = etiquette.mainImage
        mainLabel.text = "\(etiquette.place) 꿀팁 에티켓"
        contentLabel.text = "\(etiquette.content[0])"
    }
    
    private func setupUI() {
        
        contentView.layer.cornerRadius = 16
        contentView.clipsToBounds = true
        
        
        contentView.addSubview(contentImageView)
        contentView.addSubview(mainLabel)
        contentView.addSubview(contentLabel)
        
        contentImageView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(90)
            make.top.leading.trailing.equalToSuperview()
        }
        mainLabel.snp.makeConstraints { make in
            make.top.equalTo(contentImageView.snp.bottom).offset(22)
            make.centerX.equalToSuperview()
        }
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(mainLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(18)
        }
        
        
    }
}
