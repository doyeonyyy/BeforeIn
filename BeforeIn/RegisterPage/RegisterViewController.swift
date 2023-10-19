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
    let userManager = UserManager()
    
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
        registerView.registerPhoneTextField.delegate = self
        registerView.registerPwTextField.delegate = self
        registerView.registerCheckTextField.delegate = self
    }
    
    func setupAddTarget(){
        registerView.checkIdButton.addTarget(self, action: #selector(checkIdButtonTapped), for: .touchUpInside)
        registerView.checkPhoneButton.addTarget(self, action: #selector(checkPhoneButtonTapped), for: .touchUpInside)
        registerView.showPwButton.addTarget(self, action: #selector(showPwButtonTapped), for: .touchUpInside)
        registerView.showCheckButton.addTarget(self, action: #selector(showCheckButtonTapped), for: .touchUpInside)
        registerView.registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        registerView.registerCheckTextField.addTarget(self, action: #selector(writingComplete), for: .editingChanged)
    }
    
    
    // MARK: - @objc
    // 아이디 중복확인
    @objc func checkIdButtonTapped() {
        if let email = registerView.registerIdTextField.text?.trimmingCharacters(in: .whitespaces) {
            if !email.isEmpty {
                userManager.findUser(email: email) { isUsed in
                    if isUsed != nil {
                        self.showAlertOneButton(title: "사용 불가능", message: "이미 사용중인 아이디입니다.", buttonTitle: "확인")
                        self.registerView.checkIdButton.backgroundColor = .systemGray6
                        self.registerView.checkIdButton.setTitleColor(UIColor.black, for: .normal)

                    } else {
                        self.showAlertOneButton(title: "사용 가능", message: "사용 가능한 아이디입니다.", buttonTitle: "확인")
                        self.registerView.checkIdButton.backgroundColor = .BeforeInRed
                        self.registerView.checkIdButton.setTitleColor(UIColor.white, for: .normal)

                    }
                }
            } else  {
                showAlertOneButton(title: "이메일", message: "이메일 주소를 입력하세요.", buttonTitle: "확인")
            }
        }
    }

    
    @objc func checkPhoneButtonTapped(){
        print("휴대폰인증 버튼 눌림")
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
    
    
    // 1. 회원가입 (유효성 검사 로직 필요)
    @objc func registerButtonTapped() {
        if let email = registerView.registerIdTextField.text?.trimmingCharacters(in: .whitespaces),
           let name = registerView.registerNameTextField.text?.trimmingCharacters(in: .whitespaces),
           let phone = registerView.registerPhoneTextField.text?.trimmingCharacters(in: .whitespaces),
           let password = registerView.registerPwTextField.text?.trimmingCharacters(in: .whitespaces),
           let checkPassword = registerView.registerCheckTextField.text?.trimmingCharacters(in: .whitespaces) {
            
            if email.isEmpty {
                showAlertOneButton(title: "이메일", message: "이메일 주소를 입력하세요.", buttonTitle: "확인")
            } else if name.isEmpty {
                showAlertOneButton(title: "이름", message: "이름을 입력하세요.", buttonTitle: "확인")
            } else if phone.isEmpty {
                showAlertOneButton(title: "휴대폰번호", message: "휴대폰번호를 입력하세요.", buttonTitle: "확인")
            } else if password.isEmpty {
                showAlertOneButton(title: "비밀번호", message: "비밀번호를 입력하세요.", buttonTitle: "확인")
            } else if checkPassword.isEmpty {
                showAlertOneButton(title: "비밀번호 확인", message: "비밀번호를 다시 한번 입력하세요.", buttonTitle: "확인")
            } else if password != checkPassword {
                showAlertOneButton(title: "비밀번호 불일치", message: "비밀번호가 일치하지 않습니다.", buttonTitle: "확인")
            } else {
                let newUser = User(email: email, name: name, nickname: "", profileImage: UIImage(systemName: "person.fill")!, level: 1, phone: phone)
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
           let phone = registerView.registerPhoneTextField.text?.trimmingCharacters(in: .whitespaces),
           let password = registerView.registerPwTextField.text?.trimmingCharacters(in: .whitespaces),
           let checkPassword = registerView.registerCheckTextField.text?.trimmingCharacters(in: .whitespaces) {
            
            let isFormValid = !email.isEmpty && !name.isEmpty && !phone.isEmpty && !password.isEmpty && !checkPassword.isEmpty
            
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
            registerView.registerPhoneTextField.becomeFirstResponder()
        } else if textField == registerView.registerPhoneTextField {
            registerView.registerPwTextField.becomeFirstResponder()
        } else if textField == registerView.registerPwTextField {
            registerView.registerCheckTextField.becomeFirstResponder()
        } else if textField == registerView.registerCheckTextField {
            registerButtonTapped()
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == registerView.registerCheckTextField {
            UIView.animate(withDuration: 0.3) {
                self.view.frame.origin.y = -180
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
        } else if textField == registerView.registerPhoneTextField {
            let intSet = CharacterSet.decimalDigits
            let replaceIntSet = CharacterSet(charactersIn: input)
            
            if !intSet.isSuperset(of: replaceIntSet) {
                showAlertOneButton(title: "입력 오류", message: "숫자를 입력해주세요.", buttonTitle: "확인")
                return false
            }
        }
        return true
    }


}

