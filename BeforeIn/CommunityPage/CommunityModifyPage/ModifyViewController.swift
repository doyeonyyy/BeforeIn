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
        addTarget()
        setupContent()
    }
    func addTarget() {
        modifyVeiw.contentTextView.delegate = self
        modifyVeiw.confirmButton.addTarget(self, action: #selector(confirmButtonClick), for: .touchUpInside)
        modifyVeiw.dailyButton.addTarget(self, action: #selector(dailyButtonTapped), for: .touchUpInside)
        modifyVeiw.qnaButton.addTarget(self, action: #selector(qnaButtonTapped), for: .touchUpInside)
    }
    
    private func setupContent() {
        modifyVeiw.mainTextField.text = post?.title
        modifyVeiw.contentTextView.text = post?.content
        modifyVeiw.contentTextView.textColor = .black
    }
    
    @objc func dailyButtonTapped() {
        modifyVeiw.dailyButton.isSelected = !modifyVeiw.dailyButton.isSelected // 반전 선택 상태

        if modifyVeiw.dailyButton.isSelected {
            // 버튼이 선택된 경우
            modifyVeiw.dailyButton.setTitleColor(.white, for: .normal)
            modifyVeiw.dailyButton.backgroundColor = UIColor.BeforeInRed
            modifyVeiw.qnaButton.setTitleColor(UIColor.BeforeInRed, for: .normal)
            modifyVeiw.qnaButton.backgroundColor = .white
        } else {
            // 버튼이 선택되지 않은 경우
            modifyVeiw.dailyButton.setTitleColor(UIColor.BeforeInRed, for: .normal)
            modifyVeiw.dailyButton.backgroundColor = .white
        }
        print("일상잡담 카테고리 선택")
    }

    @objc func qnaButtonTapped() {
        modifyVeiw.qnaButton.isSelected = !modifyVeiw.qnaButton.isSelected

        if modifyVeiw.qnaButton.isSelected {
            modifyVeiw.qnaButton.setTitleColor(.white, for: .normal)
            modifyVeiw.qnaButton.backgroundColor = UIColor.BeforeInRed
            modifyVeiw.dailyButton.setTitleColor(UIColor.BeforeInRed, for: .normal)
            modifyVeiw.dailyButton.backgroundColor = .white
        } else {
            modifyVeiw.qnaButton.setTitleColor(UIColor.BeforeInRed, for: .normal)
            modifyVeiw.qnaButton.backgroundColor = .white
        }
        print("궁금해요 카테고리 선택")
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
