//
//  NicknameEditViewController.swift
//  BeforeIn
//
//  Created by t2023-m0048 on 2023/10/22.
//

import UIKit
import SnapKit
import Then
import FirebaseAuth
import FirebaseFirestore

class NicknameEditViewController: BaseViewController {
    
    private let userManager = UserManager()
    var checkNickname = false
    
    // MARK: - UI Properties
    private let editNicknameLabel = UILabel().then {
        $0.text = "변경할 닉네임을 입력하세요."
        $0.font = UIFont.systemFont(ofSize: 16)
    }
    
    private let editNicknameTextField = UITextField().then {
        $0.setPlaceholderFontSize(size: 14, text: "8자 이하 닉네임을 입력하세요.")
        $0.autocapitalizationType = .none
        $0.autocorrectionType = .no
        $0.spellCheckingType = .no
        $0.clearsOnBeginEditing = false
        $0.layer.cornerRadius = 8
    }
    
    private let editBottom = UIView().then {
        $0.backgroundColor = .systemGray2
    }
    
    private let checkNicknameButton = UIButton().then {
        $0.setTitle("  중복확인  ", for: .normal)
        $0.setTitleColor(UIColor.black, for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 11)
        $0.backgroundColor = .systemGray6
        $0.layer.cornerRadius = 12
        $0.layer.masksToBounds = true
        $0.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
    }
    
    private let changeNicknameButton = UIButton().then {
        $0.setTitle("닉네임 변경", for: .normal)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        $0.backgroundColor = .BeforeInRed
        $0.layer.cornerRadius = 8
        $0.layer.masksToBounds = true
    }
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubview()
        setUI()
        setTextField()
        addTarget()
    }
    
    
    // MARK: - Methods
    func addSubview(){
        view.addSubview(editNicknameLabel)
        view.addSubview(editNicknameTextField)
        view.addSubview(editBottom)
        view.addSubview(checkNicknameButton)
        view.addSubview(changeNicknameButton)
    }
    
    func setUI() {
        
        setNavigationBar()
        
        editNicknameLabel.snp.makeConstraints {
            $0.top.equalTo(self.view.snp.top).offset(120)
            $0.left.equalTo(self.view.snp.left).offset(24)
        }
        
        editNicknameTextField.snp.makeConstraints {
            $0.top.equalTo(editNicknameLabel.snp.bottom).offset(17)
            $0.left.equalTo(self.view.snp.left).offset(24)
            $0.right.equalTo(self.view.snp.right).offset(-70)
        }
        
        editBottom.snp.makeConstraints {
            $0.left.right.equalTo(self.view).inset(24)
            $0.bottom.equalTo(editNicknameTextField.snp.bottom).offset(4)
            $0.height.equalTo(1)
        }
        
        checkNicknameButton.snp.makeConstraints {
            $0.right.equalTo(self.view.snp.right).offset(-25)
            $0.bottom.equalTo(editBottom.snp.top).offset(-5)
        }
        
        changeNicknameButton.snp.makeConstraints{
            $0.left.right.equalTo(self.view).inset(24)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-20)
            $0.height.equalTo(50)
        }
    }
    
    func setNavigationBar() {
        view.backgroundColor = .systemBackground
        self.title = "닉네임 수정"
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]
    }
    
    func setTextField(){
        editNicknameTextField.delegate = self
    }
    
    func addTarget(){
        checkNicknameButton.addTarget(self, action: #selector(checkNicknameButtonTapped), for: .touchUpInside)
        changeNicknameButton.addTarget(self, action: #selector(changeNicknameButtonTapped), for: .touchUpInside)
        editNicknameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
    }
    
    
    // MARK: - @objc
    @objc func checkNicknameButtonTapped() {
        if let nickname = editNicknameTextField.text?.trimmingCharacters(in: .whitespaces) {
            if !nickname.isEmpty {
                userManager.findNickname(nickname: nickname) { isUsed in
                    if isUsed != nil {
                        self.showAlertOneButton(title: "사용 불가능", message: "이미 사용중인 닉네임입니다.", buttonTitle: "확인")
                        self.checkNicknameButton.backgroundColor = .systemGray6
                        self.checkNicknameButton.setTitleColor(UIColor.black, for: .normal)
                        self.checkNickname = false
                    } else {
                        self.showAlertOneButton(title: "사용 가능", message: "사용 가능한 닉네임입니다. \n 입력하신 닉네임은 아이디 찾기시 이용됩니다.", buttonTitle: "확인")
                        self.checkNicknameButton.backgroundColor = .BeforeInRed
                        self.checkNicknameButton.setTitleColor(UIColor.white, for: .normal)
                        self.checkNickname = true
                    }
                }
            }
        }
    }
    
    @objc func changeNicknameButtonTapped() {
        if let newNickname = editNicknameTextField.text?.trimmingCharacters(in: .whitespaces),
           let userEmail = Auth.auth().currentUser?.email,
           checkNickname {
            let userCollection = Firestore.firestore().collection("User")
            userCollection.whereField("email", isEqualTo: userEmail).getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("에러: \(error.localizedDescription)")
                } else if let documents = querySnapshot?.documents, !documents.isEmpty {
                    let userDocument = documents[0]
                    userDocument.reference.updateData(["nickname": newNickname]) { error in
                        if let error = error {
                            print("닉네임 변경 실패: \(error.localizedDescription)")
                        } else {
                            print("닉네임 변경 성공: \(newNickname)")
                            currentUser.nickname = newNickname
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                }
            }
        } else {
            showAlertOneButton(title: "중복 확인", message: "닉네임 중복 확인을 해주세요.", buttonTitle: "확인")
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        checkNicknameButton.backgroundColor = .systemGray6
        checkNicknameButton.setTitleColor(UIColor.black, for: .normal)
        checkNickname = false
    }
    
}


// MARK: - UITextFieldDelegate
extension NicknameEditViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString input: String) -> Bool {
        if textField == editNicknameTextField {
            
            let maxLength = 8
            let oldText = textField.text ?? ""
            let addedText = input
            let newText = oldText + addedText
            let newTextLength = newText.count
            
            if newTextLength <= maxLength {
                return true
            }
            
            let lastWordOfOldText = String(oldText[oldText.index(before: oldText.endIndex)])
            let separatedCharacters = lastWordOfOldText.decomposedStringWithCanonicalMapping.unicodeScalars.map{ String($0) }
            let separatedCharactersCount = separatedCharacters.count
            
            if separatedCharactersCount == 1 && !addedText.isConsonant {
                return true
            }
            if separatedCharactersCount == 2 && addedText.isConsonant {
                return true
            }
            if separatedCharactersCount == 3 && addedText.isConsonant {
                return true
            }
            return false
        }
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        var text = textField.text ?? ""
        let maxLength = 8
        if text.count > maxLength {
            let startIndex = text.startIndex
            let endIndex = text.index(startIndex, offsetBy: maxLength - 1)
            let fixedText = String(text[startIndex...endIndex])
            textField.text = fixedText
        }
    }
}



