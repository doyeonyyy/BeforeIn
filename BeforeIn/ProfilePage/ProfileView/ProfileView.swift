//
//  ProfileView.swift
//  BeforeIn
//
//  Created by t2023-m079 on 10/18/23.
//

import Foundation
import UIKit

class ProfileView: UIView {
    private let nicknameLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private let idLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = UIColor.systemGray
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    let editNicknameButton = UIButton().then {
        $0.setTitle("닉네임 수정", for: .normal)
        $0.setTitleColor(.systemGray, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 15)
    }

    let circularImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "profilePlaceholder")
        imageView.backgroundColor = .systemGray6
        imageView.layer.cornerRadius = 45
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let editProfileButton = UIButton().then {
        let image = UIImage(systemName: "pencil.circle.fill")
        let resizedImage = $0.resizeImageButton(image: image, width: 25, height: 25, color: .systemGray4)
        $0.setImage(resizedImage, for: .normal)
    }
    
    private let grayRectangle: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 18
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderColor = UIColor.systemGray5.cgColor
        view.layer.borderWidth = 0.5
        view.clipsToBounds = true
        return view
    }()
    
    private let nameBoxLabel: UILabel = {
        let label = UILabel()
        label.text = "000님은 현재"
//        label.textColor = UIColor(red: 0.192, green: 0.192, blue: 0.192, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private let levelLabel: UILabel = {
        let label = UILabel()
        label.text = "검은머리 짐승"
//        label.textColor = UIColor(red: 0.192, green: 0.192, blue: 0.192, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private let level: UILabel = {
        let label = UILabel()
        label.text = "Lv l"
        label.textColor = .BeforeInRed
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private let mentBoxLabel: UILabel = {
        let label = UILabel()
        label.text = "입니다"
//        label.textColor = UIColor(red: 0.192, green: 0.192, blue: 0.192, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private let levelImageStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let levelImage1: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "level1")
        return imageView
    }()
    private let levelImage2: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "level2")
        return imageView
    }()
    private let levelImage3: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "level3")
        return imageView
    }()
    private let levelImage4: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "level4")
        return imageView
    }()
    private let levelImage5: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "level5")
        return imageView
    }()
    
    private let levelProgressView = UIProgressView().then {
        $0.progress = 0.5
        $0.progressTintColor = .BeforeInRed
    }
    
    private let line: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var profileViewModel: ProfileViewModel?{
        didSet {
            profileViewModel?.updateView = { [weak self] in
                self?.updateView()
            }
            profileViewModel?.updateView = { [weak self] in
                self?.updateView()
            }
            updateView()
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
        defineLayoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSubViews()
        defineLayoutConstraints()
    }
    
    private func addSubViews() {
        addSubview(nicknameLabel)
        addSubview(idLabel)
        addSubview(editNicknameButton)
        addSubview(circularImageView)
        addSubview(editProfileButton)
        addSubview(grayRectangle)
        
        grayRectangle.addSubview(nameBoxLabel)
        grayRectangle.addSubview(levelLabel)
        grayRectangle.addSubview(mentBoxLabel)
        grayRectangle.addSubview(level)
        grayRectangle.addSubview(levelProgressView)
        grayRectangle.addSubview(levelImageStackView)
        
        levelImageStackView.addArrangedSubview(levelImage1)
        levelImageStackView.addArrangedSubview(levelImage2)
        levelImageStackView.addArrangedSubview(levelImage3)
        levelImageStackView.addArrangedSubview(levelImage4)
        levelImageStackView.addArrangedSubview(levelImage5)

        addSubview(line)
        addSubview(tableView)
    }
    
    private func defineLayoutConstraints() {
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(80)
            make.leading.equalTo(self.snp.leading).offset(24)
        }
        
        idLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom).offset(5)
            make.leading.equalTo(self.snp.leading).offset(24)
        }
        
        editNicknameButton.snp.makeConstraints { make in
            make.top.equalTo(idLabel.snp.bottom).offset(12)
            make.leading.equalTo(self.snp.leading).offset(24)
        }
        
        circularImageView.snp.makeConstraints { make in
            make.width.height.equalTo(90)
            make.trailing.equalTo(self.snp.trailing).offset(-24)
            make.top.equalTo(self.snp.top).offset(80)
        }
        
        editProfileButton.snp.makeConstraints { make in
            make.top.equalTo(circularImageView.snp.bottom).offset(-25)
            make.leading.equalTo(circularImageView.snp.trailing).offset(-20)
        }
        
        grayRectangle.snp.makeConstraints { make in
            make.width.equalToSuperview().inset(24)
            make.height.equalTo(170)
            make.top.equalTo(circularImageView.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
        }
        
        nameBoxLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
        }
        
        levelLabel.snp.makeConstraints { make in
            make.top.equalTo(nameBoxLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
        }
        
        mentBoxLabel.snp.makeConstraints { make in
            make.top.equalTo(nameBoxLabel.snp.bottom).offset(14)
            make.leading.equalTo(levelLabel.snp.trailing).offset(6)
        }
        
        level.snp.makeConstraints { make in
            make.top.equalTo(nameBoxLabel.snp.bottom).offset(8)
            make.trailing.equalToSuperview().offset(-24)
        }
        
        levelImageStackView.snp.makeConstraints { make in
            make.bottom.equalTo(levelProgressView.snp.top)
            make.height.equalTo(70)
            make.leading.trailing.equalToSuperview().inset(8)
        }
        
        levelProgressView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(4)
            make.bottom.equalToSuperview().offset(-16)
        }
        
        line.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
            make.top.equalTo(grayRectangle.snp.bottom).offset(15)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(line.snp.bottom).offset(-15)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    private func updateView() {
        levelProgressUpdate(profileViewModel?.level ?? 1)
        nicknameLabel.text = profileViewModel?.nameBox
        nameBoxLabel.text = profileViewModel?.nickname
        level.text = profileViewModel?.levelNumberText
        levelLabel.text = profileViewModel?.levelText
     //   circularImageView.image = profileViewModel?.profileImage
        idLabel.text = profileViewModel?.email
    }
    
    func updateProfileImage() {
        if let imageURL = URL(string: profileViewModel?.imageURL ?? "") {
            self.circularImageView.setImageUrl(imageURL.absoluteString)
        }
    }

    private func levelProgressUpdate(_ level: Int) {
        let progress = Float(level) / 5
        levelProgressView.setProgress(progress, animated: true)
    }
    

   
}
