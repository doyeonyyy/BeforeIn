//
//  UserAccountDeletionPage.swift
//  BeforeIn
//
//  Created by t2023-m0048 on 2023/10/27.
//

import UIKit
import FirebaseAuth

class UserAccountDeletionViewController: BaseViewController {
    // MARK: - Properties
    let userManager = UserManager()
    
    // MARK: - UI Properties
    private let checkPasswordLabel = UILabel().then {
        $0.text = "현재 비밀번호를 입력하세요."
        $0.font = UIFont.systemFont(ofSize: 16)
    }
    let checkPasswordTextField = UITextField().then {
        $0.autocapitalizationType = .none
        $0.autocorrectionType = .no
        $0.spellCheckingType = .no
        $0.isSecureTextEntry = true
        $0.clearsOnBeginEditing = false
        $0.layer.cornerRadius = 8
    }
    private let checkBottom = UIView().then {
        $0.backgroundColor = .systemGray2
    }
    let checkPasswordButton = UIButton().then {
        $0.setImage(UIImage(systemName: "eye"), for: .normal)
        $0.tintColor = .black
    }
    private let userDeletionButton = UIButton().then {
        $0.setTitle("회원탈퇴", for: .normal)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        $0.backgroundColor = .BeforeInRed
        $0.layer.cornerRadius = 8
        $0.layer.masksToBounds = true
    }
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        addSubview()
        setUI()
        setTextField()
        addTarget()
    }
    
    func setNavigationBar() {
        view.backgroundColor = .systemBackground
        self.title = "회원탈퇴"
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]
    }
    
    func addSubview(){
        view.addSubview(checkPasswordLabel)
        view.addSubview(checkPasswordTextField)
        view.addSubview(checkBottom)
        view.addSubview(checkPasswordButton)
        view.addSubview(userDeletionButton)
    }
    
    func setUI() {
        checkPasswordLabel.snp.makeConstraints {
            $0.top.equalTo(view.snp.top).offset(120)
            $0.left.equalTo(view.snp.left).offset(24)
        }
        
        checkPasswordTextField.snp.makeConstraints {
            $0.top.equalTo(checkPasswordLabel.snp.bottom).offset(17)
            $0.left.equalTo(view.snp.left).offset(24)
            $0.right.equalTo(view.snp.right).offset(-70)
        }
        
        checkBottom.snp.makeConstraints {
            $0.left.right.equalTo(view).inset(24)
            $0.bottom.equalTo(checkPasswordTextField.snp.bottom).offset(4)
            $0.height.equalTo(1)
        }
        
        checkPasswordButton.snp.makeConstraints {
            $0.right.equalTo(view.snp.right).offset(-25)
            $0.bottom.equalTo(checkBottom.snp.top).offset(-5)
        }
        
        userDeletionButton.snp.makeConstraints{
            $0.left.right.equalTo(view).inset(24)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            $0.height.equalTo(50)
        }
        
    }
    
    func setTextField(){
        checkPasswordTextField.delegate = self
    }
    
    func addTarget(){
        checkPasswordButton.addTarget(self, action: #selector(checkPasswordButtonTapped), for: .touchUpInside)
        userDeletionButton.addTarget(self, action: #selector(userDeletionButtonTapped), for: .touchUpInside)
        
    }
    
    
    // MARK: - @objc
    @objc func checkPasswordButtonTapped() {
        checkPasswordButton.isSelected.toggle()
        
        if checkPasswordButton.isSelected {
            checkPasswordButton.setImage(UIImage(systemName: "eye"), for: .normal)
            checkPasswordTextField.isSecureTextEntry = true
        } else {
            checkPasswordButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
            checkPasswordTextField.isSecureTextEntry = false
        }
    }
    
    @objc func userDeletionButtonTapped() {
        let user = Auth.auth().currentUser
        let credential = EmailAuthProvider.credential(withEmail: user?.email ?? "", password: checkPasswordTextField.text ?? "")
        
        user?.reauthenticate(with: credential) { _, error in
            if let error = error {
                print("현재 비밀번호 확인 실패: \(error.localizedDescription)")
                self.showAlertOneButton(title: "비밀번호 확인 실패", message: "입력한 비밀번호가 올바르지 않습니다.", buttonTitle: "확인")
            } else {
                print("비밀번호 확인 성공")
                self.showAlertTwoButton(title: "회원탈퇴", message: "정말 탈퇴하시겠습니까?", button1Title: "확인", button2Title: "취소") {
                    if let user = Auth.auth().currentUser {
                        self.userManager.deleteUser(user: user)
                        user.delete { error in
                            if let error = error {
                                print("Firebase Error: \(error)")
                            } else {
                                print("회원탈퇴 성공")
                                let loginViewController = LoginViewController()
                                self.transitionToRootView(view: UINavigationController(rootViewController: loginViewController))
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    
}

// MARK: - UITextFieldDelegate
extension UserAccountDeletionViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    
}
