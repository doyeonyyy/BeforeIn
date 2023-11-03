//
//  MainView.swift
//  BeforeIn
//
//  Created by t2023-m079 on 10/12/23.
//

import UIKit
import NVActivityIndicatorView
import SnapKit
import Then

class MainView: UIView {
    
    private let scrollView = UIScrollView().then {
        $0.alwaysBounceVertical = true
        $0.showsVerticalScrollIndicator = false
    }
    
    private let contentView = UIView()
    
    let indicator = NVActivityIndicatorView(frame: CGRect(x: 162, y: 100, width: 50, height: 50),
                                            type: .lineSpinFadeLoader,
                                            color: .BeforeInRed,
                                            padding: 0)
    
    private let nameLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 16)
    }
    
    private let levelLabel = UILabel().then {
        $0.font = UIFont.boldSystemFont(ofSize: 24)
    }
    
    private let subLabel = UILabel().then {
        $0.text = "입니다"
        $0.font = UIFont.systemFont(ofSize: 16)
    }
    
    private let level: UILabel = {
        let label = UILabel()
        label.text = "Lvl"
        label.textColor = .BeforeInRed
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    let profileImageView = UIImageView().then {
        $0.image = #imageLiteral(resourceName: "profilePlaceholder")
        $0.layer.cornerRadius = 50
        $0.clipsToBounds = true
        $0.backgroundColor = .systemGray6
    }
    
    let quizButton = UIButton().then{
        $0.setTitle("퀴즈 다시 풀러가기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        $0.backgroundColor = .BeforeInRed
        $0.layer.cornerRadius = 6
        $0.clipsToBounds = true
    }
    
    private let divider = UIView().then {
        $0.backgroundColor = .systemGray6
    }
    
    private let etiquetteLabel = UILabel().then{
        $0.text = "알아두면 쓸모있는 에티켓"
        $0.font = UIFont.boldSystemFont(ofSize: 16)
    }
    
    let randomButton = UIButton().then {
        $0.setImage(UIImage(systemName: "arrow.counterclockwise"), for: .normal)
        $0.tintColor = .SystemBlack
    }
    
    private let etiquetteView = UIView().then{
        $0.backgroundColor = .systemBackground
        $0.layer.cornerRadius = 16
        
        // 그림자
//        $0.layer.borderWidth = 1
//        $0.layer.borderColor = UIColor.systemBackground.cgColor
//        $0.layer.shadowOpacity = 0.5
//        $0.layer.shadowColor = UIColor.systemGray4.cgColor
//        $0.layer.masksToBounds = false
//        $0.layer.shadowOffset = CGSize(width: 4, height: 8)
//        $0.layer.shadowRadius = 1
    }
    
    private let quotes1 = UILabel().then{
        $0.text = "\""
        $0.font = UIFont.boldSystemFont(ofSize: 24)
    }
    
    private let quotes2 = UILabel().then{
        $0.text = "\""
        $0.font = UIFont.boldSystemFont(ofSize: 24)
    }
    
    private let etiquetteViewContent = UILabel().then{
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.numberOfLines = 0
        $0.textAlignment = .center
    }
    
    private let recentlyEtiquette = UILabel().then{
        $0.text = "최근 본 에티켓"
        $0.font = UIFont.boldSystemFont(ofSize: 16)
    }
    
    let recentlyEtiquetteLabel = UILabel().then {
        $0.text = "에티켓을 확인해보세요 🧐"
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.textColor = .systemGray
    }

    var recentlyEtiquetteCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        layout.itemSize = CGSize(width: 100, height: 100)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private let recommendLabel = UILabel().then {
        $0.text = "장소별 상황 추천"
        $0.font = UIFont.boldSystemFont(ofSize: 16)
    }
    
    var recommendEtiquetteCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        layout.itemSize = CGSize(width: 183, height: 200)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        return collectionView
    }()
    
    let seeMoreButton = UIButton().then{
        $0.setTitle("더보기", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        $0.setTitleColor(.black, for: .normal)
        
    }
    
    var mainViewModel: MainViewModel? {
        didSet {
            mainViewModel?.updateProfileImage = { [weak self] in
                self?.updateProfileImage()
            }
            mainViewModel?.updateView = { [weak self] in
                self?.updateView()
            }
            updateView()
        }
    }

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubviews()
        setupConstraint()
    }
    
    private func setupSubviews() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(indicator)
        contentView.addSubview(nameLabel)
        contentView.addSubview(levelLabel)
        contentView.addSubview(subLabel)
        //contentView.addSubview(level)
        contentView.addSubview(profileImageView)
        contentView.addSubview(quizButton)
        contentView.addSubview(divider)
        contentView.addSubview(etiquetteLabel)
        contentView.addSubview(randomButton)
        contentView.addSubview(etiquetteView)
        etiquetteView.addSubview(quotes1)
        etiquetteView.addSubview(quotes2)
        etiquetteView.addSubview(etiquetteViewContent)
        contentView.addSubview(recentlyEtiquette)
        contentView.addSubview(recentlyEtiquetteLabel)
        contentView.addSubview(recentlyEtiquetteCollectionView)
        contentView.addSubview(recommendLabel)
        contentView.addSubview(recommendEtiquetteCollectionView)
        contentView.addSubview(seeMoreButton)
    }
    
    private func setupConstraint() {
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalTo(self)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
        }
        contentView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        indicator.snp.makeConstraints {
               $0.center.equalToSuperview()
           }

        nameLabel.snp.makeConstraints { make in
            make.bottom.equalTo(levelLabel.snp.top).offset(-10)
            make.leading.equalToSuperview().offset(24)
        }
        levelLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.centerY).offset(-2)
            make.leading.equalToSuperview().offset(24)
        }
        subLabel.snp.makeConstraints { make in
            make.bottom.equalTo(levelLabel.snp.bottom).offset(-2)
            make.leading.equalTo(levelLabel.snp.trailing).offset(4)
        }
//        level.snp.makeConstraints { make in
//            make.bottom.equalTo(subLabel.snp.bottom)
//            make.leading.equalTo(subLabel.snp.trailing).offset(16)
//        }
        profileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.width.height.equalTo(100)
            make.trailing.equalToSuperview().inset(24)
        }
        quizButton.snp.makeConstraints { make in
            make.top.equalTo(levelLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(24)
            make.width.equalTo(160)
            make.height.equalTo(36)
        }
        divider.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(1)
            make.top.equalTo(quizButton.snp.bottom).offset(20)
        }
        etiquetteLabel.snp.makeConstraints { make in
            make.top.equalTo(divider.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(26)
        }
        randomButton.snp.makeConstraints { make in
            make.top.equalTo(etiquetteLabel.snp.top)
            make.leading.equalTo(etiquetteLabel.snp.trailing).offset(5)
        }
        etiquetteView.snp.makeConstraints { make in
            make.top.equalTo(etiquetteLabel.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(24)
            make.height.equalTo(116)
        }
        quotes1.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(3)
        }
        quotes2.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(3)
            make.bottom.equalToSuperview().inset(10)
        }
        etiquetteViewContent.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().inset(10)
            make.trailing.leading.equalToSuperview().inset(16)
        }
        recentlyEtiquette.snp.makeConstraints { make in
            make.top.equalTo(etiquetteView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(24)
        }
        recentlyEtiquetteLabel.snp.makeConstraints { make in
            make.top.equalTo(recentlyEtiquette.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
        }
        recentlyEtiquetteCollectionView.snp.makeConstraints { make in
            make.top.equalTo(recentlyEtiquette.snp.bottom).offset(16)
            make.leading.equalToSuperview().inset(8)
            make.trailing.equalToSuperview()
            make.height.equalTo(100)
        }
        recommendLabel.snp.makeConstraints { make in
            make.top.equalTo(recentlyEtiquetteCollectionView.snp.bottom).offset(30)
            make.leading.equalToSuperview().inset(24)
        }
        recommendEtiquetteCollectionView.snp.makeConstraints { make in
            make.top.equalTo(recommendLabel.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(240)
            make.bottom.equalToSuperview().offset(-20)
        }
        seeMoreButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(24)
            make.centerY.equalTo(recommendLabel)
        }
    }
    
    private func updateView() {
        nameLabel.text = "\(mainViewModel?.nickname ?? "ㅇㅇㅇ")님은 현재"
        levelLabel.text = mainViewModel?.level
        etiquetteViewContent.text = "\(mainViewModel?.etiquetteContent ?? "예")"
        level.text = mainViewModel?.levelNumberText
        print("view 업데이트")
    }
    
    private func updateProfileImage() {
        if let imageURL = URL(string: mainViewModel?.profileImageURL ?? "") {
            self.profileImageView.setImageUrl(imageURL.absoluteString)
        }
    }
    
    
  }


