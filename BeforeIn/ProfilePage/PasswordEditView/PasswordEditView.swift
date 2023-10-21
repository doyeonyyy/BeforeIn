//
//  PasswordEditView.swift
//  BeforeIn
//
//  Created by t2023-m0048 on 2023/10/21.
//

import UIKit
import SnapKit
import Then

class PasswordEditView: UIView {
    
    // MARK: - UI Properties
    private let editPasswordLabel = UILabel().then {
        $0.text = "기존 비밀번호를 입력하세요."
        $0.font = UIFont.systemFont(ofSize: 18)
    }
    
    private let editPasswordTextField = UITextField().then {
        $0.autocapitalizationType = .none
        $0.autocorrectionType = .no
        $0.spellCheckingType = .no
        $0.clearsOnBeginEditing = false
        $0.backgroundColor = .systemGray6
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        $0.leftViewMode = .always
        $0.layer.cornerRadius = 8
        
    }
    
    private let newPasswordLabel = UILabel().then {
        $0.text = "변경할 비밀번호를 입력하세요."
        $0.font = UIFont.systemFont(ofSize: 18)
    }
    
    private let newPasswordTextField = UITextField().then {
        $0.autocapitalizationType = .none
        $0.autocorrectionType = .no
        $0.spellCheckingType = .no
        $0.clearsOnBeginEditing = false
        $0.backgroundColor = .systemGray6
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        $0.leftViewMode = .always
        $0.layer.cornerRadius = 8
    }
    
    private let checkPasswordLabel = UILabel().then {
        $0.text = "변경할 비밀번호를 한번 더 입력하세요."
        $0.font = UIFont.systemFont(ofSize: 18)
    }
    
    private let checkPasswordTextField = UITextField().then {
        $0.autocapitalizationType = .none
        $0.autocorrectionType = .no
        $0.spellCheckingType = .no
        $0.clearsOnBeginEditing = false
        $0.backgroundColor = .systemGray6
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        $0.leftViewMode = .always
        $0.layer.cornerRadius = 8
    }
    
    private let changePasswordButton = UIButton().then {
        $0.setTitle("비밀번호 변경", for: .normal)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        $0.backgroundColor = .BeforeInRed
        $0.layer.cornerRadius = 15
        $0.layer.masksToBounds = true
    }
    
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Methods
    func addSubview() {
        addSubview(editPasswordLabel)
        addSubview(editPasswordTextField)
        addSubview(newPasswordLabel)
        addSubview(newPasswordTextField)
        addSubview(changePasswordButton)
        addSubview(checkPasswordLabel)
        addSubview(checkPasswordTextField)
    }
    
    func setUI(){
        editPasswordLabel.snp.makeConstraints {
            $0.top.equalTo(self.snp.top).offset(100)
            $0.left.equalTo(self.snp.left).offset(24)
        }
        
        editPasswordTextField.snp.makeConstraints {
            $0.top.equalTo(editPasswordLabel.snp.bottom).offset(12)
            $0.left.right.equalTo(self).inset(24)
            $0.height.equalTo(40)
        }
        
        newPasswordLabel.snp.makeConstraints {
            $0.top.equalTo(editPasswordTextField.snp.bottom).offset(24)
            $0.left.equalTo(self.snp.left).offset(24)
        }
        
        newPasswordTextField.snp.makeConstraints {
            $0.top.equalTo(newPasswordLabel.snp.bottom).offset(12)
            $0.left.right.equalTo(self).inset(24)
            $0.height.equalTo(40)
        }
        
        checkPasswordLabel.snp.makeConstraints {
            $0.top.equalTo(newPasswordTextField.snp.bottom).offset(24)
            $0.left.equalTo(self.snp.left).offset(24)
        }
        
        checkPasswordTextField.snp.makeConstraints {
            $0.top.equalTo(checkPasswordLabel.snp.bottom).offset(12)
            $0.left.right.equalTo(self).inset(24)
            $0.height.equalTo(40)
        }
        
        changePasswordButton.snp.makeConstraints{
            $0.left.right.equalTo(self).inset(24)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-20)
            $0.height.equalTo(50)
        }
    }
    
    
    
    
    
}
