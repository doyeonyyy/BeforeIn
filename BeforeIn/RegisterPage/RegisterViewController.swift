//
//  RegisterViewController.swift
//  BeforeIn
//
//  Created by t2023-m079 on 10/11/23.
//

import UIKit

class RegisterViewController: BaseViewController {
    
    // MARK: - Properties
    private let registerView = RegisterView()
    
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
    
    @objc func registerButtonTapped() {
        print("등록버튼 눌림")
        self.navigationController?.popViewController(animated: true)
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

