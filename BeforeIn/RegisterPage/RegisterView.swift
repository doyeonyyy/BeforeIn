//
//  RegisterView.swift
//  BeforeIn
//
//  Created by t2023-m0048 on 2023/10/12.
//

import UIKit
import SnapKit
import Then


class RegisterView: UIView {
    
    // MARK: - UI Properties
    lazy var registerIdLabel = UILabel().then {
        $0.text = "아이디"
        $0.font = UIFont.boldSystemFont(ofSize: 16)
    }
    lazy var registerIdTextField = UITextField().then {
        $0.setPlaceholderFontSize(size: 14, text: "이메일 주소를 입력하세요.")
        $0.autocapitalizationType = .none
        $0.autocorrectionType = .no
        $0.spellCheckingType = .no
        $0.keyboardType = .emailAddress
        $0.clearsOnBeginEditing = false
    }
    lazy var registerIdBottom = UIView().then {
        $0.backgroundColor = .systemGray2
    }
    lazy var authIdButton = UIButton().then {
        $0.setTitle("  인증메일전송  ", for: .normal)
        $0.setTitleColor(UIColor.black, for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        $0.backgroundColor = .systemGray6
        $0.layer.cornerRadius = 15
        $0.layer.masksToBounds = true
    }
    
    lazy var authCodeLabel = UILabel().then {
        $0.text = "인증번호"
        $0.font = UIFont.boldSystemFont(ofSize: 16)
    }
    lazy var authCodeTextField = UITextField().then {
        $0.setPlaceholderFontSize(size: 14, text: "받으신 인증번호를 입력하세요.")
        $0.autocapitalizationType = .none
        $0.autocorrectionType = .no
        $0.spellCheckingType = .no
        $0.clearsOnBeginEditing = false
    }
    lazy var authCodeBottom = UIView().then {
        $0.backgroundColor = .systemGray2
    }
    lazy var timerLabel = UILabel().then {
        $0.text = ""
        $0.font = UIFont.boldSystemFont(ofSize: 18)
        $0.textColor = .BeforeInRed
    }
    lazy var authCodeButton = UIButton().then {
        $0.setTitle("  인증확인  ", for: .normal)
        $0.setTitleColor(UIColor.black, for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        $0.backgroundColor = .systemGray6
        $0.layer.cornerRadius = 15
        $0.layer.masksToBounds = true
    }
    
    lazy var registerNameLabel = UILabel().then {
        $0.text = "이름"
        $0.font = UIFont.boldSystemFont(ofSize: 16)
    }
    lazy var registerNameTextField = UITextField().then {
        $0.setPlaceholderFontSize(size: 14, text: "실명을 입력하세요.")
        $0.autocapitalizationType = .none
        $0.autocorrectionType = .no
        $0.spellCheckingType = .no
        $0.clearsOnBeginEditing = false
    }
    lazy var registerNameBottom = UIView().then {
        $0.backgroundColor = .systemGray2
    }
    
    lazy var registerNicknameLabel = UILabel().then {
        $0.text = "닉네임"
        $0.font = UIFont.boldSystemFont(ofSize: 16)
    }
    lazy var registerNicknameTextField = UITextField().then {
        $0.setPlaceholderFontSize(size: 14, text: "8자 이하 닉네임을 입력하세요.")
        $0.autocapitalizationType = .none
        $0.autocorrectionType = .no
        $0.spellCheckingType = .no
        $0.clearsOnBeginEditing = false
    }
    lazy var registerNicknameBottom = UIView().then {
        $0.backgroundColor = .systemGray2
    }
    lazy var checkNicknameButton = UIButton().then {
        $0.setTitle("  중복확인  ", for: .normal)
        $0.setTitleColor(UIColor.black, for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        $0.backgroundColor = .systemGray6
        $0.layer.cornerRadius = 15
        $0.layer.masksToBounds = true
    }
    
    lazy var registerPwLabel = UILabel().then {
        $0.text = "비밀번호"
        $0.font = UIFont.boldSystemFont(ofSize: 16)
    }
    lazy var registerPwTextField = UITextField().then {
        $0.setPlaceholderFontSize(size: 14, text: "대소문자, 특수문자, 숫자 포함 8자 이상")
        $0.autocapitalizationType = .none
        $0.autocorrectionType = .no
        $0.spellCheckingType = .no
        $0.textContentType = .newPassword
        $0.isSecureTextEntry = true
        $0.clearsOnBeginEditing = false
    }
    lazy var registerPwBottom = UIView().then {
        $0.backgroundColor = .systemGray2
    }
    lazy var showPwButton = UIButton().then {
        $0.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        $0.tintColor = .systemGray2
    }
    
    lazy var registerCheckLabel = UILabel().then {
        $0.text = "비밀번호 확인"
        $0.font = UIFont.boldSystemFont(ofSize: 16)
    }
    lazy var registerCheckTextField = UITextField().then {
        $0.setPlaceholderFontSize(size: 14, text: "대소문자, 특수문자, 숫자 포함 8자 이상")
        $0.autocapitalizationType = .none
        $0.autocorrectionType = .no
        $0.spellCheckingType = .no
        $0.textContentType = .newPassword
        $0.isSecureTextEntry = true
        $0.clearsOnBeginEditing = false
    }
    lazy var registerCheckBottom = UIView().then {
        $0.backgroundColor = .systemGray2
    }
    lazy var showCheckButton = UIButton().then {
        $0.setImage(UIImage(systemName: "eye"), for: .normal)
        $0.tintColor = .systemGray2
    }
    
    lazy var registerButton = UIButton().then {
        $0.setTitle("비포인 시작하기", for: .normal)
        $0.setTitleColor(UIColor.black, for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        $0.backgroundColor = .systemGray6
        $0.layer.cornerRadius = 8
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
    
    
    // MARK: - Methods
    func addSubview(){
        addSubview(registerIdLabel)
        addSubview(registerIdTextField)
        addSubview(registerIdBottom)
        addSubview(authIdButton)
        
        addSubview(authCodeLabel)
        addSubview(authCodeTextField)
        addSubview(authCodeBottom)
        addSubview(timerLabel)
        addSubview(authCodeButton)
        
        addSubview(registerNameLabel)
        addSubview(registerNameTextField)
        addSubview(registerNameBottom)
        
        addSubview(registerNicknameLabel)
        addSubview(registerNicknameTextField)
        addSubview(registerNicknameBottom)
        addSubview(checkNicknameButton)
        
        addSubview(registerPwLabel)
        addSubview(registerPwTextField)
        addSubview(registerPwBottom)
        addSubview(showPwButton)
        
        addSubview(registerCheckLabel)
        addSubview(registerCheckTextField)
        addSubview(registerCheckBottom)
        addSubview(showCheckButton)
        
        addSubview(registerButton)
    }
    
    func setUI(){
        registerIdLabel.snp.makeConstraints {
            $0.top.equalTo(self.snp.top).offset(120)
            $0.left.equalTo(self.snp.left).offset(24)
        }
        registerIdTextField.snp.makeConstraints {
            $0.top.equalTo(registerIdLabel.snp.bottom).offset(17)
            $0.left.equalTo(self.snp.left).offset(24)
            $0.right.equalTo(self.snp.right).offset(-100)
        }
        registerIdBottom.snp.makeConstraints {
            $0.left.right.equalTo(self).inset(24)
            $0.bottom.equalTo(registerIdTextField.snp.bottom).offset(4)
            $0.height.equalTo(1)
        }
        authIdButton.snp.makeConstraints{
            $0.right.equalTo(self.snp.right).offset(-25)
            $0.bottom.equalTo(registerIdBottom.snp.top).offset(-5)
        }
        
        authCodeLabel.snp.makeConstraints {
            $0.top.equalTo(registerIdBottom.snp.bottom).offset(30)
            $0.left.equalTo(self.snp.left).offset(24)
        }
        authCodeTextField.snp.makeConstraints {
            $0.top.equalTo(authCodeLabel.snp.bottom).offset(17)
            $0.left.equalTo(self.snp.left).offset(24)
            $0.right.equalTo(self.snp.right).offset(-150)
        }
        authCodeBottom.snp.makeConstraints {
            $0.left.right.equalTo(self).inset(24)
            $0.bottom.equalTo(authCodeTextField.snp.bottom).offset(4)
            $0.height.equalTo(1)
        }
        timerLabel.snp.makeConstraints {
            $0.right.equalTo(authCodeButton.snp.left).offset(-5)
            $0.bottom.equalTo(authCodeBottom.snp.top).offset(-8)
        }
        authCodeButton.snp.makeConstraints{
            $0.right.equalTo(self.snp.right).offset(-25)
            $0.bottom.equalTo(authCodeBottom.snp.top).offset(-5)
        }
        
        registerNameLabel.snp.makeConstraints {
            $0.top.equalTo(authCodeBottom.snp.bottom).offset(30)
            $0.left.equalTo(self.snp.left).offset(24)
        }
        registerNameTextField.snp.makeConstraints {
            $0.top.equalTo(registerNameLabel.snp.bottom).offset(17)
            $0.left.equalTo(self.snp.left).offset(24)
            $0.right.equalTo(self.snp.right).offset(-24)
        }
        registerNameBottom.snp.makeConstraints {
            $0.left.right.equalTo(registerNameTextField)
            $0.bottom.equalTo(registerNameTextField.snp.bottom).offset(4)
            $0.height.equalTo(1)
        }
        
        registerNicknameLabel.snp.makeConstraints {
            $0.top.equalTo(registerNameBottom.snp.bottom).offset(30)
            $0.left.equalTo(self.snp.left).offset(24)
        }
        registerNicknameTextField.snp.makeConstraints {
            $0.top.equalTo(registerNicknameLabel.snp.bottom).offset(17)
            $0.left.equalTo(self.snp.left).offset(24)
            $0.right.equalTo(self.snp.right).offset(-100)
        }
        registerNicknameBottom.snp.makeConstraints {
            $0.left.right.equalTo(self).inset(24)
            $0.bottom.equalTo(registerNicknameTextField.snp.bottom).offset(4)
            $0.height.equalTo(1)
        }
        checkNicknameButton.snp.makeConstraints{
            $0.right.equalTo(self.snp.right).offset(-25)
            $0.bottom.equalTo(registerNicknameBottom.snp.top).offset(-5)
        }
        
        registerPwLabel.snp.makeConstraints {
            $0.top.equalTo(registerNicknameBottom.snp.bottom).offset(30)
            $0.left.equalTo(self.snp.left).offset(24)
        }
        registerPwTextField.snp.makeConstraints {
            $0.top.equalTo(registerPwLabel.snp.bottom).offset(17)
            $0.left.equalTo(self.snp.left).offset(24)
            $0.right.equalTo(self.snp.right).offset(-62)
        }
        registerPwBottom.snp.makeConstraints {
            $0.left.right.equalTo(self).inset(24)
            $0.bottom.equalTo(registerPwTextField.snp.bottom).offset(4)
            $0.height.equalTo(1)
        }
        showPwButton.snp.makeConstraints{
            $0.top.equalTo(registerPwLabel.snp.bottom).offset(17)
            $0.right.equalTo(self.snp.right).offset(-30)
        }
        
        registerCheckLabel.snp.makeConstraints {
            $0.top.equalTo(registerPwBottom.snp.bottom).offset(30)
            $0.left.equalTo(self.snp.left).offset(24)
        }
        registerCheckTextField.snp.makeConstraints {
            $0.top.equalTo(registerCheckLabel.snp.bottom).offset(17)
            $0.left.equalTo(self.snp.left).offset(24)
            $0.right.equalTo(self.snp.right).offset(-62)
        }
        registerCheckBottom.snp.makeConstraints {
            $0.left.right.equalTo(self).inset(24)
            $0.bottom.equalTo(registerCheckTextField.snp.bottom).offset(4)
            $0.height.equalTo(1)
        }
        showCheckButton.snp.makeConstraints{
            $0.top.equalTo(registerCheckLabel.snp.bottom).offset(17)
            $0.right.equalTo(self.snp.right).offset(-30)
        }
        
        registerButton.snp.makeConstraints {
            $0.top.equalTo(registerCheckBottom.snp.bottom).offset(64)
            $0.left.right.equalTo(self.safeAreaLayoutGuide).inset(24)
            $0.height.equalTo(50)
        }
        
    }
    
    
    
}
