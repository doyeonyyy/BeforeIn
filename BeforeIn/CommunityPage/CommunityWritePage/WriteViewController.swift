


import UIKit
import SnapKit
import FirebaseFirestore

class WriteViewController: UIViewController {
    
    let writeView = WriteView()
    
    override func loadView() {
        view = writeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTarget()
        
    }
    func addTarget() {
        writeView.contentTextView.delegate = self
        writeView.confirmButton.addTarget(self, action: #selector(confirmButtonClick), for: .touchUpInside)
        writeView.dailyButton.addTarget(self, action: #selector(dailyButtonTapped), for: .touchUpInside)
        writeView.qnaButton.addTarget(self, action: #selector(qnaButtonTapped), for: .touchUpInside)
    }
    @objc func dailyButtonTapped() {
        writeView.dailyButton.isSelected = !writeView.dailyButton.isSelected // 반전 선택 상태

        if writeView.dailyButton.isSelected {
            // 버튼이 선택된 경우
            writeView.dailyButton.setTitleColor(.white, for: .normal)
            writeView.dailyButton.backgroundColor = UIColor.BeforeInRed
            writeView.qnaButton.setTitleColor(UIColor.BeforeInRed, for: .normal)
            writeView.qnaButton.backgroundColor = .white
        } else {
            // 버튼이 선택되지 않은 경우
            writeView.dailyButton.setTitleColor(UIColor.BeforeInRed, for: .normal)
            writeView.dailyButton.backgroundColor = .white
        }
        print("일상잡담 카테고리 선택")
    }

    @objc func qnaButtonTapped() {
        writeView.qnaButton.isSelected = !writeView.qnaButton.isSelected

        if writeView.qnaButton.isSelected {
            writeView.qnaButton.setTitleColor(.white, for: .normal)
            writeView.qnaButton.backgroundColor = UIColor.BeforeInRed
            writeView.dailyButton.setTitleColor(UIColor.BeforeInRed, for: .normal)
            writeView.dailyButton.backgroundColor = .white
        } else {
            writeView.qnaButton.setTitleColor(UIColor.BeforeInRed, for: .normal)
            writeView.qnaButton.backgroundColor = .white
        }
        print("궁금해요 카테고리 선택")
    }
    
    @objc func confirmButtonClick() {
        let db = Firestore.firestore()
        
        guard let title = writeView.mainTextField.text else {
            return
        }
        guard let content = writeView.contentTextView.text else {
            return
        }
        let writer = currentUser.email
        let writerNickName = currentUser.nickname
        let likes = 0
        let category = "질문답변"
        let postingTime = Date()
        let mydoc = db.collection("Post").document()
        let postingID = mydoc.documentID
        mydoc.setData(["writer": writer,
                       "writerNickName": writerNickName,
                       "title": title,
                       "content": content,
                       "comments": [],
                       "likes": likes,
                       "category": category,
                       "postingTime": postingTime,
                       "postingID": postingID,
                      ])
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension WriteViewController: UITextViewDelegate{
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
