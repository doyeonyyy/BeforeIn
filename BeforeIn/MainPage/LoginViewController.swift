//
//  LoginViewController.swift
//  BeforeIn
//
//  Created by t2023-m079 on 10/11/23.
//

import UIKit

class LoginViewController: BaseViewController {
    
    // MARK: - Properties
    private let loginView = LoginView()
    
    // MARK: - Life Cycle
    override func loadView(){
        view = loginView
        setTextField()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAddTarget()
    }
    
    
    // MARK: - Methods
    func setTextField(){
        loginView.idTextField.delegate = self
        loginView.pwTextField.delegate = self
    }
    
    func setupAddTarget() {
        loginView.maintainButton.addTarget(self, action: #selector(maintainButtonTapped), for: .touchUpInside)
        loginView.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        loginView.findIdButton.addTarget(self, action: #selector(findIdButtonTapped), for: .touchUpInside)
        loginView.findPwButton.addTarget(self, action: #selector(findPwButtonTapped), for: .touchUpInside)
        loginView.registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
    }
    
    
    // MARK: - @objc
    @objc func maintainButtonTapped() {
        loginView.maintainButton.isSelected.toggle()
        
        if loginView.maintainButton.isSelected {
            loginView.maintainButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        } else {
            loginView.maintainButton.setImage(UIImage(systemName: "square"), for: .normal)
        }
    }
    
    @objc func loginButtonTapped() {
        print("로그인 버튼이 눌렸습니다")
    }
    
    @objc func findIdButtonTapped() {
        print("아이디찾기 버튼이 눌렸습니다")
    }
    
    @objc func findPwButtonTapped() {
        print("비밀번호찾기 버튼이 눌렸습니다")
    }
    
    @objc func registerButtonTapped() {
        print("회원가입 버튼이 눌렸습니다")
        let registerVC = RegisterViewController()
        self.navigationController?.pushViewController(registerVC, animated: true)
        
    }
    
}


// MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == loginView.idTextField {
            loginView.pwTextField.becomeFirstResponder()
        } else if textField == loginView.pwTextField {
            loginButtonTapped()
        }
        return true
    }
    
    
}
