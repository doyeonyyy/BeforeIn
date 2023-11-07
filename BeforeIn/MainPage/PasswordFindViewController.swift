//
//  PasswordFindViewController.swift
//  BeforeIn
//
//  Created by t2023-m0048 on 2023/10/31.
//

import Foundation
import UIKit
import FirebaseAuth

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
        $0.font = UIFont.boldSystemFont(ofSize: 16)
    }
    lazy var registerIdTextField = UITextField().then {
        $0.setPlaceholderFontSize(size: 14, text: "가입하신 이메일 주소를 입력하세요.")
        $0.autocapitalizationType = .none
        $0.autocorrectionType = .no
        $0.spellCheckingType = .no
        $0.keyboardType = .emailAddress
        $0.clearsOnBeginEditing = false
    }
    lazy var registerIdBottom = UIView().then {
        $0.backgroundColor = .systemGray2
    }
    
//    lazy var authIdButton = UIButton(configuration: .filled()).then {
    lazy var authIdButton = UIButton().then {
        $0.setTitle("인증메일전송", for: .normal)
        $0.setTitleColor(.darkGray, for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 9)
        $0.backgroundColor = .systemGray6
        $0.layer.cornerRadius = 12
        $0.layer.masksToBounds = true
        $0.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
//        $0.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 40, bottom: 20, trailing: 40)
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
        $0.font = UIFont.boldSystemFont(ofSize: 14)
        $0.textColor = .BeforeInRed
    }
    lazy var authCodeButton = UIButton().then {
        $0.setTitle("인증확인", for: .normal)
        $0.setTitleColor(.darkGray, for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 9)
        $0.backgroundColor = .systemGray6
        $0.layer.cornerRadius = 12
        $0.layer.masksToBounds = true
        $0.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
    }
    
    lazy var changePasswordButton = UIButton().then {
        $0.setTitle("비밀번호 재설정 이메일 발송", for: .normal)
        $0.setTitleColor(.systemGray, for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        $0.backgroundColor = .systemGray6
        $0.layer.cornerRadius = 15
        $0.layer.masksToBounds = true
    }
    
//    $0.setTitle("로그인", for: .normal)
//    $0.setTitleColor(.white, for: .normal)
//    $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
//    $0.backgroundColor = .BeforeInRed
//    $0.layer.cornerRadius = 8
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "비밀번호 찾기"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left")?.withTintColor(.systemGray, renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(backTapped))
        
        addSubview()
        setUI()
        setTextField()
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
            $0.bottom.equalTo(registerIdBottom.snp.top).offset(-8)
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
            $0.right.equalTo(authCodeButton.snp.left).offset(-8)
            $0.centerY.equalTo(authCodeButton.snp.centerY)
        }
        authCodeButton.snp.makeConstraints{
            $0.right.equalTo(view.snp.right).offset(-25)
            $0.bottom.equalTo(authCodeBottom.snp.top).offset(-8)
        }
        
        changePasswordButton.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(24)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            $0.height.equalTo(45)
        }
    }
    
    func addTarget(){
        authIdButton.addTarget(self, action: #selector(authIdButtonTapped), for: .touchUpInside)
        authCodeButton.addTarget(self, action: #selector(authCodeButtonTapped), for: .touchUpInside)
        changePasswordButton.addTarget(self, action: #selector(changePasswordButtonTapped), for: .touchUpInside)
        registerIdTextField.addTarget(self, action: #selector(idTextFieldDidChange(_:)), for: .editingChanged)
    }
    
    func setTextField(){
        registerIdTextField.delegate = self
        authCodeTextField.delegate = self
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
            showAlertOneButton(title: "이메일 오류", message: "이메일 주소를 입력하세요.", buttonTitle: "확인")
            return
        } else if !email.isValidEmail() {
            showAlertOneButton(title: "이메일 오류", message: "올바른 이메일 주소를 입력하세요.", buttonTitle: "확인")
            return
        }
        
        userManager.findUser(email: email) { [weak self] isUsed in
            guard let self = self else { return }
            if isUsed != nil {
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
            } else {
                showAlertOneButton(title: "이메일 찾기 실패", message: "가입되지 않은 이메일입니다.", buttonTitle: "확인")
            }
        }
    }
    
    @objc func authCodeButtonTapped(){
        guard let enteredCode = authCodeTextField.text else { return }
        
        if isValidAuthCode(enteredCode) {
            showAlertOneButton(title: "인증 성공", message: "인증 성공했습니다.", buttonTitle: "확인")
            authCodeButton.backgroundColor = .BeforeInRed
            authCodeButton.setTitleColor(UIColor.white, for: .normal)
            changePasswordButton.backgroundColor = .BeforeInRed
            changePasswordButton.setTitleColor(UIColor.white, for: .normal)
            timer?.invalidate()
            timerLabel.isHidden = true
            checkEmail = true
        } else {
            showAlertOneButton(title: "인증 실패", message: "인증 실패했습니다. 다시 시도해주세요.", buttonTitle: "확인")
        }
    }
    
    @objc func changePasswordButtonTapped() {
        if let userEmail = registerIdTextField.text {
            if checkEmail {
                Auth.auth().sendPasswordReset(withEmail: userEmail) { error in
                    if let error = error {
                        self.showAlertOneButton(title: "메일 전송 실패", message: "비밀번호 재설정 이메일 발송에 실패했습니다. 다시 확인해주세요.", buttonTitle: "확인")
                        print("재설정 이메일 전송실패: \(error.localizedDescription)")
                    } else {
                        self.showAlertOneButton(title: "메일 전송", message: "비밀번호 재설정 이메일이 발송되었습니다. 비밀번호를 변경 후 다시 로그인해주세요.", buttonTitle: "확인") {
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                }
            }
            else {
                print("이메일 확인 실패")
            }
        }
    }
    
    @objc func idTextFieldDidChange(_ textField: UITextField) {
        authIdButton.backgroundColor = .systemGray6
        authIdButton.setTitleColor(.darkGray, for: .normal)
        authCodeButton.backgroundColor = .systemGray6
        authCodeButton.setTitleColor(.darkGray, for: .normal)
        changePasswordButton.backgroundColor = .systemGray6
        changePasswordButton.setTitleColor(.darkGray, for: .normal)
        userAuthCode = 9876
        checkEmail = false
    }
    @objc private func backTapped() {
        if let navigationController = self.navigationController {
            navigationController.popViewController(animated: true)
        }
    }
}


// MARK: - UITextFieldDelegate
extension PasswordFindViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == registerIdTextField {
            authCodeTextField.becomeFirstResponder()
        }
        return true
    }
    
    
}
