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
        setTextField()
        setNotification()
        setupAddTarget()
    }
    
    // MARK: - Methods
    func setTextField(){
        registerView.registerIdTextField.delegate = self
        registerView.registerPwTextField.delegate = self
        registerView.registerCheckTextField.delegate = self
        registerView.registerNameTextField.delegate = self
        registerView.registerBirthTextField.delegate = self
    }
    
    func setNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func setupAddTarget(){
        registerView.registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
    }
    
    
    // MARK: - @objc
    @objc func registerButtonTapped() {
        print("버튼 눌림")
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func keyboardWillShow(_ sender: Notification) {
        self.view.frame.origin.y = -170
    }
    
    @objc func keyboardWillHide(_ sender: Notification) {
        self.view.frame.origin.y = 0
        
    }
}


//MARK: - UITextFieldDelegate
extension RegisterViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == registerView.registerIdTextField {
            registerView.registerPwTextField.becomeFirstResponder()
        } else if textField == registerView.registerPwTextField {
            registerView.registerCheckTextField.becomeFirstResponder()
        } else if textField == registerView.registerCheckTextField {
            registerView.registerNameTextField.becomeFirstResponder()
        } else if textField == registerView.registerNameTextField {
            registerView.registerBirthTextField.becomeFirstResponder()
        } else if textField == registerView.registerBirthTextField {
            registerButtonTapped()
        }
        return true
    }
}
