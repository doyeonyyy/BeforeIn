//
//  PasswordEditViewController.swift
//  BeforeIn
//
//  Created by t2023-m0048 on 2023/10/21.
//

import UIKit
import FirebaseAuth

class PasswordEditViewController: BaseViewController {
    
    // MARK: - Properties
    let passwordEditView = PasswordEditView()
    
    // MARK: - Life Cycle
    override func loadView() {
        view = passwordEditView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextField()
        setupAddTarget()
    }
    
    
    // MARK: - Methods
    func setTextField() {
        passwordEditView.editPasswordTextField.delegate = self
        passwordEditView.newPasswordTextField.delegate = self
        passwordEditView.checkPasswordTextField.delegate = self
    }
    
    
    func setupAddTarget() {
        passwordEditView.changePasswordButton.addTarget(self, action: #selector(changePasswordButtonTapped), for: .touchUpInside)
        passwordEditView.editPasswordButton.addTarget(self, action: #selector(editPasswordButtonTapped), for: .touchUpInside)
        passwordEditView.newPasswordButton.addTarget(self, action: #selector(newPasswordButtonTapped), for: .touchUpInside)
        passwordEditView.checkPasswordButton.addTarget(self, action: #selector(checkPasswordButtonTapped), for: .touchUpInside)
    }
    
    
    // MARK: - @objc
    @objc func changePasswordButtonTapped() {
        if let currentPassword = passwordEditView.editPasswordTextField.text?.trimmingCharacters(in: .whitespaces),
           let newPassword = passwordEditView.newPasswordTextField.text?.trimmingCharacters(in: .whitespaces),
           let checkPassword = passwordEditView.checkPasswordTextField.text?.trimmingCharacters(in: .whitespaces) {
            
            if currentPassword.isEmpty || newPassword.isEmpty || checkPassword.isEmpty {
                showAlertOneButton(title: "입력 필요", message: "모든 필드를 채워주세요.", buttonTitle: "확인")
            } else {
                changePassword(currentPassword: currentPassword, newPassword: newPassword, checkPassword: checkPassword)
            }
        }
    }
    
    @objc func editPasswordButtonTapped() {
        passwordEditView.editPasswordButton.isSelected.toggle()
        
        if passwordEditView.editPasswordButton.isSelected {
            passwordEditView.editPasswordButton.setImage(UIImage(systemName: "eye"), for: .normal)
            passwordEditView.editPasswordTextField.isSecureTextEntry = true
        } else {
            passwordEditView.editPasswordButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
            passwordEditView.editPasswordTextField.isSecureTextEntry = false
        }
    }
     
    @objc func newPasswordButtonTapped() {
        passwordEditView.newPasswordButton.isSelected.toggle()
        
        if passwordEditView.newPasswordButton.isSelected {
            passwordEditView.newPasswordButton.setImage(UIImage(systemName: "eye"), for: .normal)
            passwordEditView.newPasswordTextField.isSecureTextEntry = true
        } else {
            passwordEditView.newPasswordButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
            passwordEditView.newPasswordTextField.isSecureTextEntry = false
        }
    }
    
    @objc func checkPasswordButtonTapped() {
        passwordEditView.checkPasswordButton.isSelected.toggle()
        
        if passwordEditView.checkPasswordButton.isSelected {
            passwordEditView.checkPasswordButton.setImage(UIImage(systemName: "eye"), for: .normal)
            passwordEditView.checkPasswordTextField.isSecureTextEntry = true
        } else {
            passwordEditView.checkPasswordButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
            passwordEditView.checkPasswordTextField.isSecureTextEntry = false
        }
    }
    
    
    func changePassword(currentPassword: String, newPassword: String, checkPassword: String) {
        let user = Auth.auth().currentUser
        let credential = EmailAuthProvider.credential(withEmail: user?.email ?? "", password: currentPassword)
        
        user?.reauthenticate(with: credential) { _, error in
            if let error = error {
                print("현재 비밀번호 확인 실패: \(error.localizedDescription)")
                self.showAlertOneButton(title: "비밀번호 확인 실패", message: "입력한 비밀번호가 올바르지 않습니다.", buttonTitle: "확인")
            } else if !newPassword.isValidPassword() {
                self.showAlertOneButton(title: "유효하지 않은 비밀번호", message: "비밀번호는 대소문자, 특수문자, 숫자 8자 이상이여야합니다.", buttonTitle: "확인")
            } else if newPassword != checkPassword {
                self.showAlertOneButton(title: "비밀번호 불일치", message: "변경할 비밀번호가 일치하지않습니다.", buttonTitle: "확인")
            } else {
                let user = Auth.auth().currentUser
                user?.updatePassword(to: newPassword) { error in
                    if let error = error {
                        print("비밀번호 변경 실패: \(error.localizedDescription)")
                    } else {
                        self.showAlertOneButton(title: "변경 성공", message: "비밀번호가 변경되었습니다.", buttonTitle: "확인") {
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                }
            }
        }
    }
}

    
// MARK: - UITextFieldDelegate
extension PasswordEditViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == passwordEditView.editPasswordTextField {
            passwordEditView.newPasswordTextField.becomeFirstResponder()
        } else if textField == passwordEditView.newPasswordTextField {
            passwordEditView.checkPasswordTextField.becomeFirstResponder()
        }
        return true
    }
    
    
}
