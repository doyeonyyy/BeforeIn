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
        $0.text = "현재 비밀번호를 입력하세요."
        $0.font = UIFont.systemFont(ofSize: 18)
    }
    let editPasswordTextField = UITextField().then {
        $0.autocapitalizationType = .none
        $0.autocorrectionType = .no
        $0.spellCheckingType = .no
        $0.isSecureTextEntry = true
        $0.clearsOnBeginEditing = false
        $0.layer.cornerRadius = 8
    }
    private let editBottom = UIView().then {
        $0.backgroundColor = .systemGray2
    }
    let editPasswordButton = UIButton().then {
        $0.setImage(UIImage(systemName: "eye"), for: .normal)
        $0.tintColor = .black
    }
    
    private let newPasswordLabel = UILabel().then {
        $0.text = "변경할 비밀번호를 입력하세요."
        $0.font = UIFont.systemFont(ofSize: 18)
    }
    let newPasswordTextField = UITextField().then {
        $0.placeholder = "대소문자, 특수문자, 숫자 포함 8자 이상"
        $0.autocapitalizationType = .none
        $0.autocorrectionType = .no
        $0.spellCheckingType = .no
        $0.isSecureTextEntry = true
        $0.clearsOnBeginEditing = false
        $0.layer.cornerRadius = 8
    }
    private let newBottom = UIView().then {
        $0.backgroundColor = .systemGray2
    }
    let newPasswordButton = UIButton().then {
        $0.setImage(UIImage(systemName: "eye"), for: .normal)
        $0.tintColor = .black
    }
    
    private let checkPasswordLabel = UILabel().then {
        $0.text = "변경할 비밀번호를 한번 더 입력하세요."
        $0.font = UIFont.systemFont(ofSize: 18)
    }
    let checkPasswordTextField = UITextField().then {
        $0.placeholder = "대소문자, 특수문자, 숫자 포함 8자 이상"
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
    
    let changePasswordButton = UIButton().then {
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
        addSubview(editBottom)
        addSubview(editPasswordButton)
        
        addSubview(newPasswordLabel)
        addSubview(newPasswordTextField)
        addSubview(newBottom)
        addSubview(newPasswordButton)
        
        addSubview(checkPasswordLabel)
        addSubview(checkPasswordTextField)
        addSubview(checkBottom)
        addSubview(checkPasswordButton)
        
        addSubview(changePasswordButton)
    }
    
    func setUI(){
        editPasswordLabel.snp.makeConstraints {
            $0.top.equalTo(self.snp.top).offset(120)
            $0.left.equalTo(self.snp.left).offset(24)
        }
        editPasswordTextField.snp.makeConstraints {
            $0.top.equalTo(editPasswordLabel.snp.bottom).offset(17)
            $0.left.equalTo(self.snp.left).offset(24)
            $0.right.equalTo(self.snp.right).offset(-55)
        }
        editBottom.snp.makeConstraints {
            $0.left.right.equalTo(self).inset(24)
            $0.bottom.equalTo(editPasswordTextField.snp.bottom).offset(4)
            $0.height.equalTo(1)
        }
        editPasswordButton.snp.makeConstraints{
            $0.right.equalTo(self.snp.right).offset(-25)
            $0.bottom.equalTo(editBottom.snp.top).offset(-5)
        }
        
        newPasswordLabel.snp.makeConstraints {
            $0.top.equalTo(editBottom.snp.bottom).offset(24)
            $0.left.equalTo(self.snp.left).offset(24)
        }
        newPasswordTextField.snp.makeConstraints {
            $0.top.equalTo(newPasswordLabel.snp.bottom).offset(17)
            $0.left.equalTo(self.snp.left).offset(24)
            $0.right.equalTo(self.snp.right).offset(-55)
        }
        newBottom.snp.makeConstraints {
            $0.left.right.equalTo(self).inset(24)
            $0.bottom.equalTo(newPasswordTextField.snp.bottom).offset(4)
            $0.height.equalTo(1)
        }
        newPasswordButton.snp.makeConstraints {
            $0.right.equalTo(self.snp.right).offset(-25)
            $0.bottom.equalTo(newBottom.snp.top).offset(-5)
        }
        
        
        checkPasswordLabel.snp.makeConstraints {
            $0.top.equalTo(newBottom.snp.bottom).offset(24)
            $0.left.equalTo(self.snp.left).offset(24)
        }
        checkPasswordTextField.snp.makeConstraints {
            $0.top.equalTo(checkPasswordLabel.snp.bottom).offset(17)
            $0.left.equalTo(self.snp.left).offset(24)
            $0.right.equalTo(self.snp.right).offset(-55)
        }
        checkBottom.snp.makeConstraints {
            $0.left.right.equalTo(self).inset(24)
            $0.bottom.equalTo(checkPasswordTextField.snp.bottom).offset(4)
            $0.height.equalTo(1)
        }
        checkPasswordButton.snp.makeConstraints {
            $0.right.equalTo(self.snp.right).offset(-25)
            $0.bottom.equalTo(checkBottom.snp.top).offset(-5)
        }
        
        changePasswordButton.snp.makeConstraints{
            $0.left.right.equalTo(self).inset(24)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-20)
            $0.height.equalTo(50)
        }
    }
    
    
    
    
    
}
