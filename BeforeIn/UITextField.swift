//
//  UITextField.swift
//  BeforeIn
//
//  Created by Sanghun K. on 10/12/23.
//

import UIKit

extension UITextField {
    /// UITextField 왼쪽 패딩 값을 특정 값으로 지정
    func addLeftPadding(_ value: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: value, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
  }
    
    func setPlaceholderFontSize(size: CGFloat, text: String) {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: size)
        ]
        self.attributedPlaceholder = NSAttributedString(string: text, attributes: attributes)
    }
    
    
}

