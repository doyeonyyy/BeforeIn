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
    private var checkEmail = false
    private var checkNickname = false
    
    // MARK: - Life Cycle
    override func loadView() {
        view = registerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "회원가입"
        setTextField()
        setupAddTarget()
    }
    
    deinit {
        print("회원가입VC 해제")
    }
    
    // MARK: - Methods
    func setTextField(){
        registerView.registerIdTextField.delegate = self
        registerView.registerNameTextField.delegate = self
        registerView.registerNicknameTextField.delegate = self
        registerView.registerPwTextField.delegate = self
        registerView.registerCheckTextField.delegate = self
    }
    
    func setupAddTarget(){
        registerView.checkIdButton.addTarget(self, action: #selector(checkIdButtonTapped), for: .touchUpInside)
        registerView.checkNicknameButton.addTarget(self, action: #selector(checkNicknameButtonTapped), for: .touchUpInside)
        registerView.showPwButton.addTarget(self, action: #selector(showPwButtonTapped), for: .touchUpInside)
        registerView.showCheckButton.addTarget(self, action: #selector(showCheckButtonTapped), for: .touchUpInside)
        registerView.registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        registerView.registerPwTextField.addTarget(self, action: #selector(writingComplete), for: .editingChanged)
        registerView.registerCheckTextField.addTarget(self, action: #selector(writingComplete), for: .editingChanged)
        registerView.registerIdTextField.addTarget(self, action: #selector(idTextFieldDidChange(_:)), for: .editingChanged)
        registerView.registerNicknameTextField.addTarget(self, action: #selector(nicknameTextFieldDidChange(_:)), for: .editingChanged)
    }
    
    
    // MARK: - @objc
    // 아이디 중복확인
    @objc func checkIdButtonTapped() {
        if let email = registerView.registerIdTextField.text?.trimmingCharacters(in: .whitespaces) {
            if !email.isEmpty {
                if email.isValidEmail() {
                    userManager.findUser(email: email) { isUsed in
                        if isUsed != nil {
                            self.showAlertOneButton(title: "사용 불가능", message: "이미 사용중인 아이디입니다.", buttonTitle: "확인")
                            self.registerView.checkIdButton.backgroundColor = .systemGray6
                            self.registerView.checkIdButton.setTitleColor(UIColor.black, for: .normal)
                            self.checkEmail = false
                        } else {
                            self.showAlertOneButton(title: "사용 가능", message: "사용 가능한 아이디입니다.", buttonTitle: "확인")
                            self.registerView.checkIdButton.backgroundColor = .BeforeInRed
                            self.registerView.checkIdButton.setTitleColor(UIColor.white, for: .normal)
                            self.checkEmail = true
                            self.writingComplete()
                        }
                    }
                } else {
                    showAlertOneButton(title: "이메일 형식 오류", message: "올바른 이메일 주소를 입력하세요.", buttonTitle: "확인")
                }
            }
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
            registerView.showPwButton.setImage(UIImage(systemName: "eye"), for: .normal)
            registerView.registerPwTextField.isSecureTextEntry = true
        } else {
            registerView.showPwButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
            registerView.registerPwTextField.isSecureTextEntry = false
        }
    }
    
    @objc func showCheckButtonTapped(){
        registerView.showCheckButton.isSelected.toggle()
        
        if registerView.showCheckButton.isSelected {
            registerView.showCheckButton.setImage(UIImage(systemName: "eye"), for: .normal)
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
                showAlertOneButton(title: "비밀번호 형식 오류", message: "비밀번호 형식에 맞게 입력해주세요. (대소문자, 특수문자, 숫자 포함 8자이상)", buttonTitle: "확인")
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
    
    
    @objc func idTextFieldDidChange(_ textField: UITextField) {
        registerView.checkIdButton.backgroundColor = .systemGray6
        registerView.checkIdButton.setTitleColor(UIColor.black, for: .normal)
        checkEmail = false
    }
    
    @objc func nicknameTextFieldDidChange(_ textField: UITextField) {
        registerView.checkNicknameButton.backgroundColor = .systemGray6
        registerView.checkNicknameButton.setTitleColor(UIColor.black, for: .normal)
        checkNickname = false
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
        if textField == registerView.registerCheckTextField {
            UIView.animate(withDuration: 0.3) {
                self.view.frame.origin.y = -190
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
        if textField == registerView.registerNameTextField {
            let stringSet = CharacterSet.letters
            let replaceStringSet = CharacterSet(charactersIn: input)
            
            if !stringSet.isSuperset(of: replaceStringSet) {
                showAlertOneButton(title: "입력 오류", message: "문자를 입력해주세요.", buttonTitle: "확인")
                return false
            }
        }
        return true
    }
    
    
}

