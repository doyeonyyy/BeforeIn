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
    
    // UI Properties
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
    
    
    override init(frame: CGRect){
        super.init(frame: frame)
        addSubView()
        setUI()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // Methods
    func addSubView(){
        addSubview(idView)
        addSubview(pwView)
    }
    
    
    func setUI(){
        idLabel.snp.makeConstraints {
            $0.top.equalTo(idView.snp.top).offset(14)
            $0.left.equalTo(idView.snp.left).offset(8)
            $0.right.equalTo(idView.snp.right).offset(-8)
            $0.bottom.equalTo(idView.snp.bottom).offset(-14)
        }
        
        idTextField.snp.makeConstraints {
            $0.edges.equalTo(idView)
        }
        
        idView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(321)
            $0.left.right.equalTo(self.safeAreaLayoutGuide).inset(24)
        }
        
        pwLabel.snp.makeConstraints {
            $0.top.equalTo(pwView.snp.top).offset(14)
            $0.left.equalTo(pwView.snp.left).offset(8)
            $0.right.equalTo(pwView.snp.right).offset(-8)
            $0.bottom.equalTo(pwView.snp.bottom).offset(-14)
        }
        
        pwTextField.snp.makeConstraints {
            $0.edges.equalTo(pwView)
        }
        
        pwView.snp.makeConstraints {
            $0.top.equalTo(idView.snp.bottom).offset(8)
            $0.left.right.equalTo(self.safeAreaLayoutGuide).inset(24)
        }
        
    }
    
    
}



