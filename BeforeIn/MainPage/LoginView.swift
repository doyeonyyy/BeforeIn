//
//  LoginView.swift
//  BeforeIn
//
//  Created by t2023-m0048 on 2023/10/12.
//

import UIKit
import SnapKit
import Then

class LoginView: UIView {
    
    // MARK: - UI Properties
   lazy var idView = UIView().then {
        $0.layer.borderColor = UIColor.systemGray2.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 8
        $0.layer.masksToBounds = true
        $0.addSubview(idTextField)
        $0.addSubview(idLabel)
    }
    
    lazy var idTextField = UITextField().then {
        $0.autocapitalizationType = .none
        $0.autocorrectionType = .no
        $0.spellCheckingType = .no
        $0.keyboardType = .emailAddress
        $0.clearsOnBeginEditing = false
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 0))
        $0.leftViewMode = .always
    }
    
    lazy var idLabel = UILabel().then {
        $0.text = "아이디를 입력하세요."
        $0.font = UIFont.systemFont(ofSize: 18)
        $0.textColor = .systemGray2
    }
    
    lazy var pwView = UIView().then {
        $0.layer.borderColor = UIColor.systemGray2.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 8
        $0.layer.masksToBounds = true
        $0.addSubview(pwTextField)
        $0.addSubview(pwLabel)
        $0.addSubview(showPwButton)
    }
    
    lazy var pwTextField = UITextField().then {
        $0.autocapitalizationType = .none
        $0.autocorrectionType = .no
        $0.spellCheckingType = .no
        $0.isSecureTextEntry = true
        $0.clearsOnBeginEditing = false
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 0))
        $0.leftViewMode = .always
    }
    
    lazy var pwLabel = UILabel().then {
        $0.text = "비밀번호를 입력하세요."
        $0.font = UIFont.systemFont(ofSize: 18)
        $0.textColor = .systemGray2
    }
    
    lazy var showPwButton = UIButton().then {
        $0.setImage(UIImage(systemName: "eye"), for: .normal)
        $0.tintColor = .black
    }
    
    lazy var maintainLabel = UILabel().then {
        $0.text = "로그인 상태 유지"
        $0.font = UIFont.systemFont(ofSize: 16)
    }
    
    lazy var maintainButton = UIButton().then {
        $0.setImage(UIImage(systemName: "square"), for: .normal)
        $0.tintColor = .black
    }
    
    lazy var maintainStackView = UIStackView().then {
        $0.addArrangedSubview(maintainLabel)
        $0.addArrangedSubview(maintainButton)
        $0.spacing = 5
        $0.axis = .horizontal
    }
    
    lazy var loginButton = UIButton().then {
        $0.setTitle("로그인", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        $0.backgroundColor = .BeforeInRed
        $0.layer.cornerRadius = 8
    }
    
    lazy var findIdButton = UIButton().then {
        $0.setTitle("아이디 찾기", for: .normal)
        $0.setTitleColor(.systemGray, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 18)
    }
    
    lazy var findPwButton = UIButton().then {
        $0.setTitle("비밀번호 찾기", for: .normal)
        $0.setTitleColor(.systemGray, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 18)
    }
    
    lazy var registerButton = UIButton().then {
        $0.setTitle("회원가입", for: .normal)
        $0.setTitleColor(.systemGray, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 18)
    }
    
    lazy var buttonStackView = UIStackView().then {
        $0.addArrangedSubview(findIdButton)
        $0.addArrangedSubview(findPwButton)
        $0.addArrangedSubview(registerButton)
        $0.spacing = 16
        $0.axis = .horizontal
        $0.alignment = .fill
    }
    
    
    // MARK: - Life Cycle
    override init(frame: CGRect){
        super.init(frame: frame)
        addSubview()
        setUI()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Methods
    func addSubview(){
        addSubview(idView)
        addSubview(pwView)
        addSubview(maintainStackView)
        addSubview(loginButton)
        addSubview(buttonStackView)
    }
    
    lazy var idLabelCenterY: NSLayoutConstraint = {
        let constraint = idLabel.centerYAnchor.constraint(equalTo: idTextField.centerYAnchor)
        return constraint
    }()
    
    lazy var pwLabelCenterY: NSLayoutConstraint = {
        let constraint = pwLabel.centerYAnchor.constraint(equalTo: pwTextField.centerYAnchor)
        return constraint
    }()
    
    func setUI(){
        idLabel.translatesAutoresizingMaskIntoConstraints = false
        pwLabel.translatesAutoresizingMaskIntoConstraints = false
        
        idLabel.snp.makeConstraints { make in
            make.left.equalTo(idView.snp.left).offset(8)
            make.right.equalTo(idView.snp.right).offset(-8)
            idLabelCenterY.isActive = true
        }
        
        idTextField.snp.makeConstraints {
            $0.edges.equalTo(idView)
            $0.height.equalTo(48)
        }
        
        idView.snp.makeConstraints {
            $0.top.equalTo(self.snp.top).offset(321)
            $0.left.right.equalTo(self.safeAreaLayoutGuide).inset(24)
        }
        
        showPwButton.snp.makeConstraints {
            $0.right.equalTo(pwView.snp.right).offset(-8)
            $0.centerY.equalTo(pwView)
        }
        
        pwLabel.snp.makeConstraints {
            $0.left.equalTo(pwView.snp.left).offset(8)
            $0.right.equalTo(pwView.snp.right).offset(-8)
            pwLabelCenterY.isActive = true
        }
        
        pwTextField.snp.makeConstraints {
            $0.edges.equalTo(pwView)
            $0.height.equalTo(48)
        }
        
        pwView.snp.makeConstraints {
            $0.top.equalTo(idView.snp.bottom).offset(8)
            $0.left.right.equalTo(self.safeAreaLayoutGuide).inset(24)
        }
        
        maintainStackView.snp.makeConstraints{
            $0.top.equalTo(pwView.snp.bottom).offset(17)
            $0.left.equalTo(self.safeAreaLayoutGuide.snp.left).offset(25)
        }
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(maintainStackView.snp.bottom).offset(40)
            $0.left.right.equalTo(self.safeAreaLayoutGuide).inset(24)
            $0.height.equalTo(50)
        }
        
        buttonStackView.snp.makeConstraints{
            $0.top.equalTo(loginButton.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
    }
    
    
    
    
}



