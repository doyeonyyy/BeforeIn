//
//  RegisterViewController.swift
//  BeforeIn
//
//  Created by t2023-m079 on 10/11/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class RegisterViewController: BaseViewController {
    
    // MARK: - Properties
    private let registerView = RegisterView()
    private let db = Firestore.firestore()
    
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
    }
    
    
    // MARK: - @objc
    @objc func checkIdButtonTapped(){
        print("중복확인 버튼 눌림")
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
   
    // 1. 회원가입 (빈 문자열 로직, 얼랏, 유효성검사)
    @objc func registerButtonTapped() {
        if let email = registerView.registerIdTextField.text,
           let password = registerView.registerPwTextField.text,
           let checkPassword = registerView.registerCheckTextField.text,
           let name = registerView.registerNameTextField.text {
            
            // 빈 문자열 확인 로직 추가해야됨
            if name.isEmpty {
                let alert = UIAlertController(title: "이름", message: "이름을 입력하세요.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            if password == checkPassword {
                Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                    if let e = error {
                        print(e.localizedDescription)
                    } else {
                        self.db.collection("User").addDocument(data: [
                            "email" : email,
                            "password" : password,
                            "name" : name
                        ])
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            } else {
                let alert = UIAlertController(title: "비밀번호 불일치", message: "비밀번호가 일치하지 않습니다.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
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
    
    
}

