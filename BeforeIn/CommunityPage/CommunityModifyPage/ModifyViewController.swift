//
//  ModifyViewController.swift
//  BeforeIn
//
//  Created by t2023-m079 on 10/23/23.
//

import UIKit
import FirebaseFirestore

class ModifyViewController: BaseViewController {
    
    let db = Firestore.firestore()
    var post: Post?
    let modifyVeiw = ModifyView()
    
    override func loadView() {
        view = modifyVeiw
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTarget()
        setupContent()
    }
    
    func addTarget() {
        modifyVeiw.mainTextField.delegate = self
        modifyVeiw.contentTextView.delegate = self
        modifyVeiw.confirmButton.addTarget(self, action: #selector(confirmButtonClick), for: .touchUpInside)
        modifyVeiw.dailyButton.addTarget(self, action: #selector(dailyButtonTapped), for: .touchUpInside)
        modifyVeiw.qnaButton.addTarget(self, action: #selector(qnaButtonTapped), for: .touchUpInside)
    }
    
    private func setupContent() {
        if let post = post {
            modifyVeiw.mainTextField.text = post.title
            modifyVeiw.contentTextView.text = post.content
            modifyVeiw.contentTextView.textColor = .systemBlack
            switch post.category {
            case "일상잡담": modifyVeiw.dailyButton.isSelected = true
            case "궁금해요": modifyVeiw.qnaButton.isSelected = true
            default: break
            }
        }
        
    }
    
    @objc func dailyButtonTapped() {
        guard !modifyVeiw.dailyButton.isSelected else { return }
        
        modifyVeiw.dailyButton.isSelected.toggle()
        if modifyVeiw.qnaButton.isSelected {
            modifyVeiw.qnaButton.isSelected = false
        }
    }
    
    @objc func qnaButtonTapped() {
        guard !modifyVeiw.qnaButton.isSelected else { return }
        
        modifyVeiw.qnaButton.isSelected.toggle()
        if modifyVeiw.dailyButton.isSelected {
            modifyVeiw.dailyButton.isSelected = false
        }
    }
    
    @objc func confirmButtonClick() {
        guard let postID = post?.postID else { return }
        guard let title = modifyVeiw.mainTextField.text, !title.trimmingCharacters(in: .whitespaces).isEmpty else {
               showAlertOneButton(title: "제목", message: "제목을 입력하세요.", buttonTitle: "확인")
               return
           }

           guard let content = modifyVeiw.contentTextView.text, !content.trimmingCharacters(in: .whitespaces).isEmpty, content != postPlaceholder else {
               showAlertOneButton(title: "내용", message: "내용을 입력하세요.", buttonTitle: "확인")
               return
           }
        
        var category = ""
        if modifyVeiw.dailyButton.isSelected {
            category = "일상잡담"
        } else if modifyVeiw.qnaButton.isSelected {
            category = "궁금해요"
        } else {
            showAlertOneButton(title: "카테고리", message: "카테고리를 선택하세요.", buttonTitle: "확인")
            return
        }
        
        let updateData: [String: Any] = [
            "title": title,
            "content": content,
            "category": category
        ]

        db.collection("Post").document(postID).setData(updateData, merge: true)

        self.navigationController?.popViewController(animated: true)
    }

}

// MARK: - UITextFieldDelegate
extension ModifyViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == modifyVeiw.mainTextField {
            let currentText = textField.text ?? ""
            let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
            
            return updatedText.count <= 20
        }
        return true
    }
}


// MARK: - UITextViewDelegate
extension ModifyViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.placeholderText {
            textView.text = nil
            textView.textColor = UIColor.systemBlack
        }
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty && !textView.isFirstResponder {
            textView.text = postPlaceholder
            textView.textColor = UIColor.placeholderText
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
           if textView == modifyVeiw.contentTextView {
               if let text = textView.text, text.count > 2000 {
                   let truncatedText = String(text.prefix(2000))
                   textView.text = truncatedText
               }
           }
       }
    
}
