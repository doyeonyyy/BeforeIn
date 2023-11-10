


import UIKit
import SnapKit
import FirebaseFirestore

class WriteViewController: BaseViewController {
    
    let writeView = WriteView()
    
    override func loadView() {
        view = writeView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        writeView.dailyButton.sendActions(for: .touchUpInside)
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTarget()
        
    }
    func addTarget() {
        writeView.mainTextField.delegate = self
        writeView.contentTextView.delegate = self
        writeView.confirmButton.addTarget(self, action: #selector(confirmButtonClick), for: .touchUpInside)
        writeView.dailyButton.addTarget(self, action: #selector(dailyButtonTapped), for: .touchUpInside)
        writeView.qnaButton.addTarget(self, action: #selector(qnaButtonTapped), for: .touchUpInside)
    }
    @objc func dailyButtonTapped() {
        writeView.dailyButton.isSelected.toggle()
        if writeView.qnaButton.isSelected {
            writeView.qnaButton.isSelected = false
        }
    }

    @objc func qnaButtonTapped() {
        writeView.qnaButton.isSelected.toggle()
        if writeView.dailyButton.isSelected {
            writeView.dailyButton.isSelected = false
        }
    }
    
    @objc func confirmButtonClick() {
        let db = Firestore.firestore()

        guard let title = writeView.mainTextField.text, !title.trimmingCharacters(in: .whitespaces).isEmpty else {
              showAlertOneButton(title: "제목", message: "제목을 입력하세요.", buttonTitle: "확인")
              return
          }

        guard let content = writeView.contentTextView.text, !content.trimmingCharacters(in: .whitespaces).isEmpty, content != "내용을 입력하세요. (2,000자 이하)" else {
              showAlertOneButton(title: "내용", message: "내용을 입력하세요.", buttonTitle: "확인")
              return
          }
        var category = ""
        if writeView.dailyButton.isSelected {
            category = "일상잡담"
        } else if writeView.qnaButton.isSelected {
            category = "궁금해요"
        } else {
            showAlertOneButton(title: "카테고리", message: "카테고리를 선택하세요.", buttonTitle: "확인")
            return
        }

        let writer = currentUser.email
        db.collection("User").whereField("email", isEqualTo: writer).getDocuments { [self] (snapshot, error) in
            if let error = error {
                print("Error fetching documents: \(error)")
            } else if let snapshot = snapshot {
                for document in snapshot.documents {
                    let userRef = db.collection("User").document(document.documentID)
                    let likes = 0
                    let postingTime = Date()
                    let mydoc = db.collection("Post").document()
                    let postingID = mydoc.documentID
                    mydoc.setData(["writer": writer,
                                   "writerNickName": userRef,
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
        }
    }

    
}

// MARK: - UITextFieldDelegate
extension WriteViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == writeView.mainTextField {
            let currentText = textField.text ?? ""
            let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
            
            return updatedText.count <= 20
        }
        return true
    }
}

// MARK: - UITextViewDelegate
extension WriteViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
            if textView.textColor == UIColor.placeholderText {
                textView.text = nil
                textView.textColor = UIColor.black
            }
            
        }
    
        func textViewDidEndEditing(_ textView: UITextView) {
            if textView.text.isEmpty {
                textView.text = "내용을 입력하세요. (2,000자 이하)"
                textView.textColor = UIColor.placeholderText
            }
        }
    
    func textViewDidChange(_ textView: UITextView) {
           if textView == writeView.contentTextView {
               if let text = textView.text, text.count > 2000 {
                   let truncatedText = String(text.prefix(2000))
                   textView.text = truncatedText
               }
           }
       }
}


