//
//  ModifyViewController.swift
//  BeforeIn
//
//  Created by t2023-m079 on 10/23/23.
//

import UIKit
import FirebaseFirestore

class ModifyViewController: UIViewController {
    
    let db = Firestore.firestore()
    var post: Post?
    let modifyVeiw = ModifyView()
    
    override func loadView() {
        view = modifyVeiw
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        modifyVeiw.contentTextView.delegate = self
        modifyVeiw.confirmButton.addTarget(self, action: #selector(confirmButtonClick), for: .touchUpInside)
        setupContent()
    }
    
    private func setupContent() {
        modifyVeiw.mainTextField.text = post?.title
        modifyVeiw.contentTextView.text = post?.content
        modifyVeiw.contentTextView.textColor = .black
    }
    
    @objc func confirmButtonClick() {
        guard let title = modifyVeiw.mainTextField.text else { return }
        guard let content = modifyVeiw.contentTextView.text else { return }
        guard let postID = post?.postID else { return }
        db.collection("Post").document(postID).setData(["title": title, "content": content], merge: true)
        self.navigationController?.popViewController(animated: true)
    }
}

extension ModifyViewController: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
            if textView.textColor == UIColor.placeholderText {
                textView.text = nil
                textView.textColor = UIColor.black
            }
            
        }
        func textViewDidEndEditing(_ textView: UITextView) {
            if textView.text.isEmpty {
                textView.text = "메세지를 입력하세요"
                textView.textColor = UIColor.placeholderText
            }
        }
}
