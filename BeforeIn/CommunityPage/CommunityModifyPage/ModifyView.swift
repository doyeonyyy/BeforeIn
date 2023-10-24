//
//  ModifyView.swift
//  BeforeIn
//
//  Created by t2023-m079 on 10/24/23.
//

import UIKit
import SnapKit
import Then

class ModifyView: UIView {

    let mainLabel = UILabel().then {
        $0.text = "제목"
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    }
    
    let mainCustomView = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor =  UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
        $0.layer.cornerRadius = 6
    }
    
    let mainTextField = UITextField().then {
        $0.placeholder = "제목을 입력해주세요"
        $0.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    }
    
    let contentsLabel = UILabel().then {
        $0.text = "내용"
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    }
    
    let contentsCustomView = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor =  UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
        $0.layer.cornerRadius = 10
    }

    let contentTextView = UITextView().then{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.textColor = UIColor.placeholderText
        $0.text = "메세지를 입력하세요"
    }
    
    
    let categoryMainLabel = UILabel().then {
        $0.text = "카테고리 설정"
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    }
    
    let categoryView = UIView().then {
        $0.layer.cornerRadius = 16.5
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(red: 0.616, green: 0.102, blue: 0.102, alpha: 1).cgColor
    }
    
    let categoryLabel = UILabel().then {
        $0.text = "요즘 문화"
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = UIColor(red: 0.616, green: 0.102, blue: 0.102, alpha: 1)
    }
    
    let categoryView2 = UIView().then {
        $0.layer.cornerRadius = 16.5
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(red: 0.616, green: 0.102, blue: 0.102, alpha: 1).cgColor
    }
    
    let categoryLabel2 = UILabel().then {
        $0.text = "우리 끼리"
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = UIColor(red: 0.616, green: 0.102, blue: 0.102, alpha: 1)
    }
    
    let confirmButton = UIButton().then {
        $0.backgroundColor = .BeforeInRed
        $0.setTitle("수정하기", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.layer.cornerRadius = 26
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupUI() {
        backgroundColor = .white
        addSubview(mainLabel)
        addSubview(contentsLabel)
        addSubview(mainCustomView)
        mainCustomView.addSubview(mainTextField)
        addSubview(contentsCustomView)
        contentsCustomView.addSubview(contentTextView)
        addSubview(categoryMainLabel)
        addSubview(categoryView)
        categoryView.addSubview(categoryLabel)
        addSubview(categoryView2)
        categoryView2.addSubview(categoryLabel2)
        addSubview(confirmButton)
    }
    
    func setupConstraint() {
        mainLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(120)
        }
        
        mainCustomView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(mainLabel.snp.bottom).offset(8)
            make.width.equalTo(361)
            make.height.equalTo(44)
        }
        
        mainTextField.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().inset(8)
        }
        
        contentsLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(mainCustomView.snp.bottom).offset(24)
        }
        
        contentsCustomView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(contentsLabel.snp.bottom).offset(8)
            make.width.equalTo(361)
            make.height.equalTo(140)
        }
        
        contentTextView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().inset(8)
        }
        
        categoryMainLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(contentsCustomView.snp.bottom).offset(24)
            
        }
        
        categoryView.snp.makeConstraints { make in
            make.width.equalTo(115)
            make.height.equalTo(32)
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(categoryMainLabel.snp.bottom).offset(16)
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(categoryView)
        }
        
        categoryView2.snp.makeConstraints { make in
            make.width.equalTo(115)
            make.height.equalTo(32)
            make.top.equalTo(categoryMainLabel.snp.bottom).offset(16)
            make.leading.equalTo(categoryView.snp.trailing).offset(8)
        }
        
        categoryLabel2.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(categoryView2)
        }

        confirmButton.snp.makeConstraints { make in
            make.top.equalTo(contentsCustomView.snp.bottom).offset(196)
            make.height.equalTo(52)
            make.trailing.leading.equalToSuperview().inset(16)
        }
    }

}
