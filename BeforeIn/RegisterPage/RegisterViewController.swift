//
//  RegisterViewController.swift
//  BeforeIn
//
//  Created by t2023-m079 on 10/11/23.
//

import UIKit
import FirebaseAuth

class RegisterViewController: BaseViewController {
    
    // MARK: - Properties
    private let registerView = RegisterView()
    private let userManager = UserManager()
    private var smtpManager = SMTPManager()
    private var userAuthCode = 0
    private var seconds = 181
    private var timer: Timer?
    private var checkEmail = false
    private var checkNickname = false
    
    // MARK: - Life Cycle
    override func loadView() {
        view = registerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "회원가입"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left")?.withTintColor(.systemGray, renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(backTapped))
        setTextField()
        setupAddTarget()
    }
    
    deinit {
        print("회원가입VC 해제")
    }
    
    // MARK: - Methods
    func setTextField(){
        registerView.authCodeTextField.delegate = self
        registerView.registerIdTextField.delegate = self
        registerView.registerNameTextField.delegate = self
        registerView.registerNicknameTextField.delegate = self
        registerView.registerPwTextField.delegate = self
        registerView.registerCheckTextField.delegate = self
    }
    
    func setupAddTarget(){
        registerView.authIdButton.addTarget(self, action: #selector(authIdButtonTapped), for: .touchUpInside)
        registerView.authCodeButton.addTarget(self, action: #selector(authCodeButtonTapped), for: .touchUpInside)
        registerView.checkNicknameButton.addTarget(self, action: #selector(checkNicknameButtonTapped), for: .touchUpInside)
        registerView.showPwButton.addTarget(self, action: #selector(showPwButtonTapped), for: .touchUpInside)
        registerView.showCheckButton.addTarget(self, action: #selector(showCheckButtonTapped), for: .touchUpInside)
        registerView.registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        registerView.registerIdTextField.addTarget(self, action: #selector(idTextFieldDidChange(_:)), for: .editingChanged)
        registerView.registerNicknameTextField.addTarget(self, action: #selector(nicknameTextFieldDidChange(_:)), for: .editingChanged)
        registerView.registerPwTextField.addTarget(self, action: #selector(writingComplete), for: .editingChanged)
        registerView.registerCheckTextField.addTarget(self, action: #selector(writingComplete), for: .editingChanged)
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
                self.registerView.timerLabel.text = String(format: "%d:%02d", min, sec)
            } else {
                self.registerView.timerLabel.text = "시간만료"
                self.registerView.authCodeButton.backgroundColor = .systemGray6
                self.registerView.authCodeButton.setTitleColor(UIColor.black, for: .normal)
                self.userAuthCode = 9876
            }
        }
    }
    
    
    
    
    // MARK: - @objc
    @objc func authIdButtonTapped() {
        guard let email = registerView.registerIdTextField.text else { return }
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
                self.showAlertOneButton(title: "사용 불가능", message: "이미 사용중인 아이디입니다.", buttonTitle: "확인")
                self.registerView.authIdButton.backgroundColor = .systemGray6
                self.registerView.authIdButton.setTitleColor(UIColor.black, for: .normal)
                self.checkEmail = false
            } else {
                if let timer = self.timer, timer.isValid {
                    timer.invalidate()
                    self.seconds = 181
                }
                self.showAlertOneButton(title: "인증 메일 발송", message: "인증 메일을 발송했습니다.", buttonTitle: "확인")
                { [weak self] in
                    self?.setTimer()
                    self?.registerView.timerLabel.isHidden = false
                }
                self.registerView.authIdButton.backgroundColor = .BeforeInRed
                self.registerView.authIdButton.setTitleColor(UIColor.white, for: .normal)
                
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
        guard let enteredCode = registerView.authCodeTextField.text else { return }
        
        if isValidAuthCode(enteredCode) {
            showAlertOneButton(title: "인증 성공", message: "인증 성공했습니다.", buttonTitle: "확인")
            registerView.authCodeButton.backgroundColor = .BeforeInRed
            registerView.authCodeButton.setTitleColor(UIColor.white, for: .normal)
            timer?.invalidate()
            registerView.timerLabel.isHidden = true
            checkEmail = true
        } else {
            showAlertOneButton(title: "인증 실패", message: "인증 실패했습니다. 다시 시도해주세요.", buttonTitle: "확인")
        }
    }
    
    @objc func checkNicknameButtonTapped() {
        if let nickname = registerView.registerNicknameTextField.text?.trimmingCharacters(in: .whitespaces) {
            if !nickname.isEmpty {
                userManager.findNickname(nickname: nickname) { isUsed in
                    if isUsed != nil {
                        self.showAlertOneButton(title: "사용 불가능", message: "이미 사용중인 닉네임입니다.", buttonTitle: "확인")
                        self.registerView.checkNicknameButton.backgroundColor = .systemGray6
                        self.registerView.checkNicknameButton.setTitleColor(UIColor.black, for: .normal)
                        self.checkNickname = false
                    } else {
                        self.showAlertOneButton(title: "사용 가능", message: "사용 가능한 닉네임입니다.", buttonTitle: "확인")
                        self.registerView.checkNicknameButton.backgroundColor = .BeforeInRed
                        self.registerView.checkNicknameButton.setTitleColor(UIColor.white, for: .normal)
                        self.checkNickname = true
                        self.writingComplete()
                    }
                }
            }
        }
    }
    
    @objc func showPwButtonTapped(){
        registerView.showPwButton.isSelected.toggle()
        
        if registerView.showPwButton.isSelected {
            registerView.showPwButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
            registerView.registerPwTextField.isSecureTextEntry = true
        } else {
            registerView.showPwButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
            registerView.registerPwTextField.isSecureTextEntry = false
        }
    }
    
    @objc func showCheckButtonTapped(){
        registerView.showCheckButton.isSelected.toggle()
        
        if registerView.showCheckButton.isSelected {
            registerView.showCheckButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
            registerView.registerCheckTextField.isSecureTextEntry = true
        } else {
            registerView.showCheckButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
            registerView.registerCheckTextField.isSecureTextEntry = false
        }
    }
    
    
    // 회원가입
    @objc func registerButtonTapped() {
        if let email = registerView.registerIdTextField.text?.trimmingCharacters(in: .whitespaces),
           let name = registerView.registerNameTextField.text?.trimmingCharacters(in: .whitespaces),
           let nickname = registerView.registerNicknameTextField.text?.trimmingCharacters(in: .whitespaces),
           let password = registerView.registerPwTextField.text?.trimmingCharacters(in: .whitespaces),
           let checkPassword = registerView.registerCheckTextField.text?.trimmingCharacters(in: .whitespaces),
           checkEmail, checkNickname {
            let validPw = password.isValidPassword()
            if email.isEmpty {
                showAlertOneButton(title: "이메일", message: "이메일 주소를 입력하세요.", buttonTitle: "확인")
            } else if name.isEmpty {
                showAlertOneButton(title: "이름", message: "이름을 입력하세요.", buttonTitle: "확인")
            } else if nickname.isEmpty {
                showAlertOneButton(title: "닉네임", message: "닉네임을 입력하세요.", buttonTitle: "확인")
            } else if password.isEmpty {
                showAlertOneButton(title: "비밀번호", message: "비밀번호를 입력하세요.", buttonTitle: "확인")
            } else if checkPassword.isEmpty {
                showAlertOneButton(title: "비밀번호 확인", message: "비밀번호를 다시 한번 입력하세요.", buttonTitle: "확인")
            } else if password != checkPassword {
                showAlertOneButton(title: "비밀번호 불일치", message: "비밀번호가 일치하지 않습니다.", buttonTitle: "확인")
            } else if !validPw {
                showAlertOneButton(title: "유효하지 않은 비밀번호", message: "비밀번호는 대소문자, 특수문자, 숫자 8자 이상이여야합니다.", buttonTitle: "확인")
            } else {
                let newUser = User(email: email, name: name, nickname: nickname, profileImage: "", level: 0, phone: "")
                Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                    if let e = error {
                        self.showAlertOneButton(title: "오류", message: e.localizedDescription, buttonTitle: "확인")
                    } else {
                        self.userManager.addUser(user: newUser)
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
        }
    }
    
    @objc func idTextFieldDidChange(_ textField: UITextField) {
        registerView.authIdButton.backgroundColor = .systemGray6
        registerView.authIdButton.setTitleColor(.darkGray, for: .normal)
        registerView.authCodeButton.backgroundColor = .systemGray6
        registerView.authCodeButton.setTitleColor(.darkGray, for: .normal)
        userAuthCode = 9876
        checkEmail = false
    }
    
    @objc func nicknameTextFieldDidChange(_ textField: UITextField) {
        registerView.checkNicknameButton.backgroundColor = .systemGray6
        registerView.checkNicknameButton.setTitleColor(.darkGray, for: .normal)
        checkNickname = false
    }
    
    @objc func writingComplete() {
        if let email = registerView.registerIdTextField.text?.trimmingCharacters(in: .whitespaces),
           let name = registerView.registerNameTextField.text?.trimmingCharacters(in: .whitespaces),
           let nickname = registerView.registerNicknameTextField.text?.trimmingCharacters(in: .whitespaces),
           let password = registerView.registerPwTextField.text?.trimmingCharacters(in: .whitespaces),
           let checkPassword = registerView.registerCheckTextField.text?.trimmingCharacters(in: .whitespaces) {
            let validEmail = email.isValidEmail()
            let isFormValid = !email.isEmpty && !name.isEmpty && !nickname.isEmpty && !password.isEmpty && !checkPassword.isEmpty && checkEmail && checkNickname && validEmail
            
            UIView.animate(withDuration: 0.3) {
                if isFormValid {
                    self.registerView.registerButton.backgroundColor = .BeforeInRed
                    self.registerView.registerButton.setTitleColor(UIColor.white, for: .normal)
                    self.registerView.registerButton.isEnabled = true
                } else {
                    self.registerView.registerButton.backgroundColor = .systemGray6
                    self.registerView.registerButton.isEnabled = false
                }
            }
        }
    }
    
    @objc private func backTapped() {
        if let navigationController = self.navigationController {
            navigationController.popViewController(animated: true)
        }
    }
    
    
}



//MARK: - UITextFieldDelegate
extension RegisterViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == registerView.registerIdTextField {
            registerView.registerNameTextField.becomeFirstResponder()
        } else if textField == registerView.registerNameTextField {
            registerView.registerNicknameTextField.becomeFirstResponder()
        } else if textField == registerView.registerNicknameTextField {
            registerView.registerPwTextField.becomeFirstResponder()
        } else if textField == registerView.registerPwTextField {
            registerView.registerCheckTextField.becomeFirstResponder()
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == registerView.registerPwTextField {
            UIView.animate(withDuration: 0.3) {
                self.view.frame.origin.y = -100
            }
        } else if textField == registerView.registerCheckTextField {
            UIView.animate(withDuration: 0.3) {
                self.view.frame.origin.y = -210
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                self.view.frame.origin.y = 0
            }
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3) {
            self.view.frame.origin.y = 0
        }
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString input: String) -> Bool {
        if textField == registerView.authCodeTextField {
            let numbersSet = CharacterSet(charactersIn: "0123456789")
            let replaceStringSet = CharacterSet(charactersIn: input)
            
            if !numbersSet.isSuperset(of: replaceStringSet) {
                showAlertOneButton(title: "입력 오류", message: "숫자를 입력해주세요.", buttonTitle: "확인")
                return false
            }
        } else if textField == registerView.registerNameTextField {
            let lettersSet = CharacterSet.letters
            let replaceStringSet = CharacterSet(charactersIn: input)
            
            if !lettersSet.isSuperset(of: replaceStringSet) {
                showAlertOneButton(title: "입력 오류", message: "문자를 입력해주세요.", buttonTitle: "확인")
                return false
            }
        } else if textField == registerView.registerNicknameTextField {
            let currentText = textField.text ?? ""
            let textCount = currentText.count + input.count
            
            return textCount <= 8
        }
        return true
    }
    
    
}

