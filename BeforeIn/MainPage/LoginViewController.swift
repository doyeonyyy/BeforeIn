//
//  LoginViewController.swift
//  BeforeIn
//
//  Created by t2023-m079 on 10/11/23.
//

import UIKit
import FirebaseAuth

class LoginViewController: BaseViewController {
    
    // MARK: - Properties
    private let loginView = LoginView()
    
    // MARK: - Life Cycle
    override func loadView(){
        view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextField()
        setupAddTarget()
        print("로그인VC ViewDidLoad")
    }
    
    deinit {
        print("로그인VC 해제")
    }
    
    
    // MARK: - Methods
    func setTextField(){
        loginView.idTextField.delegate = self
        loginView.pwTextField.delegate = self
    }
    
    func setupAddTarget() {
        loginView.showPwButton.addTarget(self, action: #selector(showPwButtonTapped), for: .touchUpInside)
        loginView.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        loginView.findIdButton.addTarget(self, action: #selector(findIdButtonTapped), for: .touchUpInside)
        loginView.findPwButton.addTarget(self, action: #selector(findPwButtonTapped), for: .touchUpInside)
        loginView.registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
    }
    
    
    // MARK: - @objc
    @objc func showPwButtonTapped(){
        loginView.showPwButton.isSelected.toggle()
        
        if loginView.showPwButton.isSelected {
            loginView.showPwButton.setImage(UIImage(systemName: "eye"), for: .normal)
            loginView.pwTextField.isSecureTextEntry = true
        } else {
            loginView.showPwButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
            loginView.pwTextField.isSecureTextEntry = false
        }
        
    }
    
    // 2. 로그인
    @objc func loginButtonTapped() {
        if let email = loginView.idTextField.text, let pw = loginView.pwTextField.text {
            Auth.auth().signIn(withEmail: email, password: pw) { authResult, error in
                if let error = error {
                    self.showAlertOneButton(title: "로그인 실패",
                                            message: "아이디 또는 비밀번호가 틀렸습니다.",
                                            buttonTitle: "확인") {
                    }
                    print("로그인 실패 : \(error.localizedDescription)")
                } else if let authResult = authResult {
                    print("로그인 성공")
                    let tapBarController = TapbarController()
                    self.transitionToRootView(view: tapBarController)
                }
            }
        }
    }
    
    
    @objc func findIdButtonTapped() {
        print("아이디찾기 버튼이 눌렸습니다")
    }
    
    @objc func findPwButtonTapped() {
        print("비밀번호찾기 버튼이 눌렸습니다")
    }
    
    @objc func registerButtonTapped() {
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
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == loginView.idTextField {
            loginView.idLabel.font = UIFont.systemFont(ofSize: 9)
            loginView.idLabelCenterY.constant = -13
        }
        if textField == loginView.pwTextField {
            loginView.pwLabel.font = UIFont.systemFont(ofSize: 9)
            loginView.pwLabelCenterY.constant = -13
        }
        UIView.animate(withDuration: 0.3) {
            self.loginView.layoutIfNeeded()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == loginView.idTextField {
            if loginView.idTextField.text == "" {
                loginView.idLabel.font = UIFont.systemFont(ofSize: 18)
                loginView.idLabelCenterY.constant = 0
            }
        }
        if textField == loginView.pwTextField {
            if loginView.pwTextField.text == ""{
                loginView.pwLabel.font = UIFont.systemFont(ofSize: 18)
                loginView.pwLabelCenterY.constant = 0
            }
        }
        UIView.animate(withDuration: 0.3) {
            self.loginView.layoutIfNeeded()
        }
    }
    
    
    
    
}
