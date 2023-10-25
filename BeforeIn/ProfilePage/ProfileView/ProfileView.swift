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
        label.text = "000님"
        label.textColor = UIColor(red: 0.192, green: 0.192, blue: 0.192, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private let mentLabel: UILabel = {
        let label = UILabel()
        label.text = "의 프로필 입니다"
        label.textColor = UIColor(red: 0.192, green: 0.192, blue: 0.192, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private let idLabel: UILabel = {
        let label = UILabel()
        label.text = "userid@.com"
        label.textColor = UIColor.systemGray
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    let editNicknameButton = UIButton().then {
        $0.setTitle("닉네임 수정", for: .normal)
        $0.setTitleColor(.systemGray, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16)
    }
    
    let circularImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemGray6
        imageView.layer.cornerRadius = 40
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let editProfileButton = UIButton().then {
        let image = UIImage(systemName: "pencil.circle.fill")
        let resizedImage = $0.resizeImageButton(image: image, width: 25, height: 25, color: .BeforeInRed!)
        $0.setImage(resizedImage, for: .normal)
    }
    
    private let shadowView: UIView = {
        let view = UIView()
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 18
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let grayRectangle: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 18
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let nameBoxLabel: UILabel = {
        let label = UILabel()
        label.text = "000님은 현재"
        label.textColor = UIColor(red: 0.192, green: 0.192, blue: 0.192, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private let levelLabel: UILabel = {
        let label = UILabel()
        label.text = "검은머리 짐승"
        label.textColor = UIColor(red: 0.192, green: 0.192, blue: 0.192, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private let level: UILabel = {
        let label = UILabel()
        label.text = "Lv l"
        label.textColor = .BeforeInRed
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private let mentBoxLabel: UILabel = {
        let label = UILabel()
        label.text = "입니다"
        label.textColor = UIColor(red: 0.192, green: 0.192, blue: 0.192, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private let levelRectangle: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.851, green: 0.851, blue: 0.851, alpha: 1)
        view.layer.cornerRadius = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let myLevelRectangle: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.616, green: 0.102, blue: 0.102, alpha: 1)
        view.layer.cornerRadius = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let line: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    var profileViewModel: ProfileViewModel?{
        didSet {
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
        addSubview(mentLabel)
        addSubview(idLabel)
        addSubview(editNicknameButton)
        addSubview(circularImageView)
        addSubview(editProfileButton)
        addSubview(shadowView)
        addSubview(grayRectangle)
        addSubview(nameBoxLabel)
        addSubview(levelLabel)
        addSubview(level)
        addSubview(mentBoxLabel)
        addSubview(levelRectangle)
        addSubview(myLevelRectangle)
        addSubview(line)
        addSubview(tableView)
    }
    
    private func defineLayoutConstraints() {
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(90)
            make.leading.equalTo(self.snp.leading).offset(24)
        }
        
        mentLabel.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(94)
            make.leading.equalTo(nicknameLabel.snp.trailing).offset(2)
        }
        
        idLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom).offset(8)
            make.leading.equalTo(self.snp.leading).offset(24)
        }
        
        editNicknameButton.snp.makeConstraints { make in
            make.top.equalTo(idLabel.snp.bottom).offset(1)
            make.leading.equalTo(self.snp.leading).offset(24)
        }
        
        circularImageView.snp.makeConstraints { make in
            make.width.equalTo(80)
            make.height.equalTo(80)
            make.trailing.equalTo(self.snp.trailing).offset(-24)
            make.top.equalTo(self.snp.top).offset(86)
        }
        
        editProfileButton.snp.makeConstraints { make in
            make.top.equalTo(circularImageView.snp.bottom).offset(-25)
            make.leading.equalTo(circularImageView.snp.trailing).offset(-20)
        }
        
        grayRectangle.snp.makeConstraints { make in
            make.width.equalTo(345)
            make.height.equalTo(200)
            make.top.equalTo(editNicknameButton.snp.bottom).offset(16)
            make.leading.equalTo(self.snp.leading).offset(24)
        }
        
        nameBoxLabel.snp.makeConstraints { make in
            make.top.equalTo(grayRectangle.snp.top).offset(16)
            make.leading.equalTo(grayRectangle.snp.leading).offset(16)
        }
        
        levelLabel.snp.makeConstraints { make in
            make.top.equalTo(nameBoxLabel.snp.bottom).offset(8)
            make.leading.equalTo(grayRectangle.snp.leading).offset(16)
        }
        
        level.snp.makeConstraints { make in
            make.top.equalTo(nameBoxLabel.snp.bottom).offset(8)
            make.trailing.equalTo(grayRectangle.snp.trailing).offset(-24)
        }
        
        mentBoxLabel.snp.makeConstraints { make in
            make.top.equalTo(nameBoxLabel.snp.bottom).offset(14)
            make.leading.equalTo(levelLabel.snp.trailing).offset(4)
        }
        
        levelRectangle.snp.makeConstraints { make in
            make.width.equalTo(313)
            make.height.equalTo(12)
            make.bottom.equalTo(grayRectangle.snp.bottom).offset(-16)
            make.leading.equalTo(grayRectangle.snp.leading).offset(16)
        }
        
        myLevelRectangle.snp.makeConstraints { make in
            make.width.equalTo(62)
            make.height.equalTo(12)
            make.bottom.equalTo(grayRectangle.snp.bottom).offset(-16)
            make.leading.equalTo(grayRectangle.snp.leading).offset(16)
        }
        
        line.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(3)
            make.top.equalTo(grayRectangle.snp.bottom).offset(24)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(line.snp.bottom)
            make.leading.equalTo(self.snp.leading)
            make.trailing.equalTo(self.snp.trailing)
            make.bottom.equalTo(self.snp.bottom)
        }
        
        shadowView.addSubview(grayRectangle)
        grayRectangle.snp.makeConstraints { make in
            make.edges.equalTo(shadowView)
        }
    }
    
    private func updateView() {
        nicknameLabel.text = profileViewModel?.nickname
        nameBoxLabel.text = profileViewModel?.nameBox
        level.text = profileViewModel?.levelNumberText
        levelLabel.text = profileViewModel?.levelText
        circularImageView.image = profileViewModel?.profileImage
        idLabel.text = profileViewModel?.email
        myLevelRectangleUpdate(profileViewModel?.level ?? 1)
        print("profileView 업데이트")
        
    }
    
    private func myLevelRectangleUpdate(_ level: Int) {
        let newWidth = CGFloat(level * 60)
        myLevelRectangle.snp.updateConstraints { make in
            make.width.equalTo(newWidth)
        }
    }

   
}
