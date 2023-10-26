//
//  WriteView.swift
//  BeforeIn
//
//  Created by t2023-m079 on 10/22/23.
//

import UIKit
import SnapKit
import Then

class WriteView: UIView {
    
    let mainLabel = UILabel().then {
        $0.text = "제목"
        $0.font = UIFont.systemFont(ofSize: 18)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let mainCustomView = UIView().then {
        $0.backgroundColor = .systemGray6
        $0.layer.cornerRadius = 6
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let mainTextField = UITextField().then {
        $0.placeholder = "제목을 입력하세요"
        $0.font = UIFont.systemFont(ofSize: 17)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let contentsLabel = UILabel().then {
        $0.text = "내용"
        $0.font = UIFont.systemFont(ofSize: 18)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let contentsCustomView = UIView().then {
        $0.backgroundColor = .systemGray6
        $0.layer.cornerRadius = 6
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    let contentTextView = UITextView().then {
        $0.backgroundColor = .systemGray6
        $0.font = UIFont.systemFont(ofSize: 17)
        $0.textColor = UIColor.placeholderText
        $0.text = "메세지를 입력하세요"
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let categoryMainLabel = UILabel().then {
        $0.text = "카테고리 설정"
        $0.font = UIFont.systemFont(ofSize: 18)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let dailyButton = UIButton().then {
        $0.setTitle("일상/자유", for: .normal)
        $0.setTitleColor(.BeforeInRed, for: .normal)
        $0.backgroundColor = .white
        $0.layer.borderColor = UIColor.BeforeInRed?.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 16.5
        $0.contentEdgeInsets = UIEdgeInsets(top: 5, left: 24, bottom: 5, right: 24)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .regular)
    }
    
    let qnaButton = UIButton().then {
        $0.setTitle("질문답변", for: .normal)
        $0.setTitleColor(.BeforeInRed, for: .normal)
        $0.backgroundColor = .white
        $0.layer.borderColor = UIColor.BeforeInRed?.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 16.5
        $0.contentEdgeInsets = UIEdgeInsets(top: 5, left: 24, bottom: 5, right: 24)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .regular)
    }
    
    let confirmButton = UIButton().then {
        $0.setTitle("글 올리기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        $0.backgroundColor = .BeforeInRed
        $0.layer.cornerRadius = 8
        $0.translatesAutoresizingMaskIntoConstraints = false
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
        addSubview(dailyButton)
        addSubview(qnaButton)
        addSubview(categoryMainLabel)
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
            make.height.equalTo(300)
        }
        
        contentTextView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(3)
            make.trailing.equalToSuperview().inset(8)
        }
        
        categoryMainLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(contentsCustomView.snp.bottom).offset(24)
        }
        
        dailyButton.snp.makeConstraints { make in
            make.top.equalTo(categoryMainLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
        }
        
        qnaButton.snp.makeConstraints { make in
            make.top.equalTo(categoryMainLabel.snp.bottom).offset(16)
            make.leading.equalTo(dailyButton.snp.trailing).offset(8)
        }

        confirmButton.snp.makeConstraints { make in
            make.top.equalTo(contentsCustomView.snp.bottom).offset(140)
            make.height.equalTo(50)
            make.trailing.leading.equalToSuperview().inset(24)
        }
    }
}
