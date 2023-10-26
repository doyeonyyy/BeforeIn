


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
        writeView.contentTextView.delegate = self
        writeView.confirmButton.addTarget(self, action: #selector(confirmButtonClick), for: .touchUpInside)
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
