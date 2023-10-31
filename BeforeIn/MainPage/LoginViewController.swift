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
    private let userManager = UserManager()
    
    // MARK: - Life Cycle
    override func loadView(){
        view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle()
        setTextField()
        setupAddTarget()
    }
    
    deinit {
        print("로그인VC 해제")
    }
    
    
    // MARK: - Methods
    func setTitle(){
        let titleText = " 비포인 "
        var characterIndex = 0.0
        for title in titleText {
            Timer.scheduledTimer(withTimeInterval: 0.1 * Double(characterIndex), repeats:
                                    false) { timer in
                self.loginView.beforeInLabel.text?.append(title)
            }
            characterIndex += 1
        }
    }
    
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
    
    // 로그인
    @objc func loginButtonTapped() {
        if let email = loginView.idTextField.text, let pw = loginView.pwTextField.text {
            Auth.auth().signIn(withEmail: email, password: pw) { authResult, error in
                if let error = error {
                    self.showAlertOneButton(title: "로그인 실패",
                                            message: "아이디 또는 비밀번호가 틀렸습니다.",
                                            buttonTitle: "확인") {
                    }
                    print("로그인 실패 : \(error.localizedDescription)")
                } else {
                    self.userManager.findUser(email: email) { user in
                        if let user = user {
                            currentUser = user
                            print("로그인 성공")
                            if currentUser.level == 0 {
                                let quizIntroVC = QuizIntroViewController()
                                quizIntroVC.modalPresentationStyle = .fullScreen
                                self.present(quizIntroVC, animated: true)
                            }
                            else {
                                let mainVC = TapbarController()
                                self.transitionToRootView(view: mainVC)
                            }
                            
                        }
                    }
                }
            }
        }
    }
    
    @objc func findIdButtonTapped() {
        let alertController = UIAlertController(title: "아이디 찾기", message: "등록한 닉네임을 입력해주세요.", preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.placeholder = "닉네임"
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        let findAction = UIAlertAction(title: "찾기", style: .default) { [weak self] _ in
            if let nickname = alertController.textFields?.first?.text?.trimmingCharacters(in: .whitespaces) {
                if !nickname.isEmpty {
                    self?.findIdByNickname(nickname)
                }
            }
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(findAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func findIdByNickname(_ nickname: String) {
        userManager.findNickname(nickname: nickname) { user in
            let alertTitle: String
            let alertMessage: String
            
            if let user = user {
                alertTitle = "아이디 찾기 성공"
                alertMessage = self.maskEmail(user.email)
            } else {
                alertTitle = "아이디 찾기 실패"
                alertMessage = "해당 닉네임을 가진 사용자를 찾을 수 없습니다."
            }
            self.showAlertOneButton(title: alertTitle, message: alertMessage, buttonTitle: "확인")
        }
    }
    
    func maskEmail(_ email: String) -> String {
        let emailArray = Array(email)
        var maskedEmail = ""
        for (index, char) in emailArray.enumerated() {
            if index > 1 && index < 6 && char != "@" {
                maskedEmail.append("*")
            } else {
                maskedEmail.append(char)
            }
        }
        return maskedEmail
    }
    
    @objc func findPwButtonTapped() {
        let passwordFindVC = PasswordFindViewController()
        self.navigationController?.pushViewController(passwordFindVC, animated: true)
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
