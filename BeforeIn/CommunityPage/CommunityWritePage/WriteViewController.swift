


import UIKit
import SnapKit

class WriteViewController: UIViewController {
    
    let writeView = WriteView()
    
    override func loadView() {
        view = writeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        writeView.contentTextView.delegate = self
        
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
