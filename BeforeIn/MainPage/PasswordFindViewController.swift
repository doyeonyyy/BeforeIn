//
//  PasswordFindViewController.swift
//  BeforeIn
//
//  Created by t2023-m0048 on 2023/10/31.
//

import Foundation
import UIKit

class PasswordFindViewController: BaseViewController {
    // MARK: - Properties
    private let userManager = UserManager()
    private var smtpManager = SMTPManager()
    private var userAuthCode = 0
    private var seconds = 181
    private var timer: Timer?
    private var checkEmail = false

    // MARK: - UI Properties
    lazy var registerIdLabel = UILabel().then {
        $0.text = "아이디"
        $0.font = UIFont.boldSystemFont(ofSize: 20)
    }
    lazy var registerIdTextField = UITextField().then {
        $0.placeholder = "이메일 주소를 입력하세요."
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
        $0.font = UIFont.boldSystemFont(ofSize: 20)
    }
    lazy var authCodeTextField = UITextField().then {
        $0.placeholder = "받으신 인증번호를 입력하세요."
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

    lazy var registerPwLabel = UILabel().then {
        $0.text = "비밀번호 변경"
        $0.font = UIFont.boldSystemFont(ofSize: 20)
    }
    lazy var registerPwTextField = UITextField().then {
        $0.placeholder = "대소문자, 특수문자, 숫자 포함 8자이상"
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
        $0.setImage(UIImage(systemName: "eye"), for: .normal)
        $0.tintColor = .black
    }

    lazy var registerCheckLabel = UILabel().then {
        $0.text = "비밀번호 확인"
        $0.font = UIFont.boldSystemFont(ofSize: 20)
    }
    lazy var registerCheckTextField = UITextField().then {
        $0.placeholder = "대소문자, 특수문자, 숫자 포함 8자이상"
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
        $0.tintColor = .black
    }

    lazy var changePasswordButton = UIButton().then {
        $0.setTitle("비밀번호 변경", for: .normal)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        $0.backgroundColor = .BeforeInRed
        $0.layer.cornerRadius = 15
        $0.layer.masksToBounds = true
    }
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubview()
        setUI()
        addTarget()
    }

    
    // MARK: - Methods
    func addSubview(){
        view.addSubview(registerIdLabel)
        view.addSubview(registerIdTextField)
        view.addSubview(registerIdBottom)
        view.addSubview(authIdButton)

        view.addSubview(authCodeLabel)
        view.addSubview(authCodeTextField)
        view.addSubview(authCodeBottom)
        view.addSubview(timerLabel)
        view.addSubview(authCodeButton)
        
        view.addSubview(registerPwLabel)
        view.addSubview(registerPwTextField)
        view.addSubview(registerPwBottom)
        view.addSubview(showPwButton)

        view.addSubview(registerCheckLabel)
        view.addSubview(registerCheckTextField)
        view.addSubview(registerCheckBottom)
        view.addSubview(showCheckButton)

        view.addSubview(changePasswordButton)
    }

    func setUI(){
        registerIdLabel.snp.makeConstraints {
            $0.top.equalTo(view.snp.top).offset(120)
            $0.left.equalTo(view.snp.left).offset(24)
        }
        registerIdTextField.snp.makeConstraints {
            $0.top.equalTo(registerIdLabel.snp.bottom).offset(17)
            $0.left.equalTo(view.snp.left).offset(24)
            $0.right.equalTo(view.snp.right).offset(-100)
        }
        registerIdBottom.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(24)
            $0.bottom.equalTo(registerIdTextField.snp.bottom).offset(4)
            $0.height.equalTo(1)
        }
        authIdButton.snp.makeConstraints{
            $0.right.equalTo(view.snp.right).offset(-25)
            $0.bottom.equalTo(registerIdBottom.snp.top).offset(-5)
        }

        authCodeLabel.snp.makeConstraints {
            $0.top.equalTo(registerIdBottom.snp.bottom).offset(30)
            $0.left.equalTo(view.snp.left).offset(24)
        }
        authCodeTextField.snp.makeConstraints {
            $0.top.equalTo(authCodeLabel.snp.bottom).offset(17)
            $0.left.equalTo(view.snp.left).offset(24)
            $0.right.equalTo(view.snp.right).offset(-150)
        }
        authCodeBottom.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(24)
            $0.bottom.equalTo(authCodeTextField.snp.bottom).offset(4)
            $0.height.equalTo(1)
        }
        timerLabel.snp.makeConstraints {
            $0.right.equalTo(authCodeButton.snp.left).offset(-5)
            $0.bottom.equalTo(authCodeBottom.snp.top).offset(-8)
        }
        authCodeButton.snp.makeConstraints{
            $0.right.equalTo(view.snp.right).offset(-25)
            $0.bottom.equalTo(authCodeBottom.snp.top).offset(-5)
        }

        registerPwLabel.snp.makeConstraints {
            $0.top.equalTo(authCodeBottom.snp.bottom).offset(30)
            $0.left.equalTo(view.snp.left).offset(24)
        }
        registerPwTextField.snp.makeConstraints {
            $0.top.equalTo(registerPwLabel.snp.bottom).offset(17)
            $0.left.equalTo(view.snp.left).offset(24)
            $0.right.equalTo(view.snp.right).offset(-62)
        }
        registerPwBottom.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(24)
            $0.bottom.equalTo(registerPwTextField.snp.bottom).offset(4)
            $0.height.equalTo(1)
        }
        showPwButton.snp.makeConstraints{
            $0.top.equalTo(registerPwLabel.snp.bottom).offset(17)
            $0.right.equalTo(view.snp.right).offset(-30)
        }

        registerCheckLabel.snp.makeConstraints {
            $0.top.equalTo(registerPwBottom.snp.bottom).offset(30)
            $0.left.equalTo(view.snp.left).offset(24)
        }
        registerCheckTextField.snp.makeConstraints {
            $0.top.equalTo(registerCheckLabel.snp.bottom).offset(17)
            $0.left.equalTo(view.snp.left).offset(24)
            $0.right.equalTo(view.snp.right).offset(-62)
        }
        registerCheckBottom.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(24)
            $0.bottom.equalTo(registerCheckTextField.snp.bottom).offset(4)
            $0.height.equalTo(1)
        }
        showCheckButton.snp.makeConstraints{
            $0.top.equalTo(registerCheckLabel.snp.bottom).offset(17)
            $0.right.equalTo(view.snp.right).offset(-30)
        }

        changePasswordButton.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(24)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            $0.height.equalTo(50)
        }
    }

    func addTarget(){
        authIdButton.addTarget(self, action: #selector(authIdButtonTapped), for: .touchUpInside)
        authCodeButton.addTarget(self, action: #selector(authCodeButtonTapped), for: .touchUpInside)
        showPwButton.addTarget(self, action: #selector(showPwButtonTapped), for: .touchUpInside)
        showCheckButton.addTarget(self, action: #selector(showCheckButtonTapped), for: .touchUpInside)
        changePasswordButton.addTarget(self, action: #selector(changePasswordButtonTapped), for: .touchUpInside)
    }
    
    func isValidAuthCode(_ enteredCode: String) -> Bool {
        return enteredCode == String(userAuthCode)
    }
    
    func setTimer() {
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [self] timer in
            self.seconds -= 1
            let min = self.seconds / 60
            let sec = self.seconds % 60
            
            if self.seconds > 0 {
                self.timerLabel.text = String(format: "%d:%02d", min, sec)
            } else {
                self.timerLabel.text = "시간만료"
                self.authCodeButton.backgroundColor = .systemGray6
                self.authCodeButton.setTitleColor(UIColor.black, for: .normal)
                self.userAuthCode = 9876
            }
        }
    }
    
    // MARK: - @objc
    @objc func authIdButtonTapped() {
        guard let email = registerIdTextField.text else { return }
        if email.isEmpty {
            showAlertOneButton(title: "이메일 형식 오류", message: "이메일 주소를 입력하세요.", buttonTitle: "확인")
            return
        } else if !email.isValidEmail() {
            showAlertOneButton(title: "이메일 형식 오류", message: "올바른 이메일 주소를 입력하세요.", buttonTitle: "확인")
            return
        }
        
        userManager.findUser(email: email) { [weak self] isUsed in
            guard let self = self else { return }
            if isUsed != nil {
                self.showAlertOneButton(title: "사용 불가능", message: "이미 사용중인 아이디입니다.", buttonTitle: "확인")
                self.authIdButton.backgroundColor = .systemGray6
                self.authIdButton.setTitleColor(UIColor.black, for: .normal)
                self.checkEmail = false
            } else {
                if let timer = self.timer, timer.isValid {
                    timer.invalidate()
                    self.seconds = 181
                }
                self.showAlertOneButton(title: "인증 메일 발송", message: "인증 메일을 발송했습니다.", buttonTitle: "확인")
                { [weak self] in
                    self?.setTimer()
                    self?.timerLabel.isHidden = false
                }
                authIdButton.backgroundColor = .BeforeInRed
                authIdButton.setTitleColor(UIColor.white, for: .normal)
                
                DispatchQueue.global().async {
                    self.smtpManager.sendAuth(userEmail: email) { [weak self] (authCode, success) in
                        guard let self = self else { return }
                        
                        if authCode >= 10000 && authCode <= 99999 && success {
                            userAuthCode = authCode
                        }
                    }
                }
            }
        }
    }
    
    @objc func authCodeButtonTapped(){
        guard let enteredCode = authCodeTextField.text else { return }
        
        if isValidAuthCode(enteredCode) {
            showAlertOneButton(title: "인증 성공", message: "인증 성공했습니다.", buttonTitle: "확인")
            authCodeButton.backgroundColor = .BeforeInRed
            authCodeButton.setTitleColor(UIColor.white, for: .normal)
            timer?.invalidate()
            timerLabel.isHidden = true
            checkEmail = true
        } else {
            showAlertOneButton(title: "인증 실패", message: "인증 실패했습니다. 다시 시도해주세요.", buttonTitle: "확인")
        }
    }
    
    
    @objc func showPwButtonTapped(){
        
    }
    
    
    @objc func showCheckButtonTapped(){
        
        
    }
     
    @objc func changePasswordButtonTapped(){
        
        
    }
    
    

}
