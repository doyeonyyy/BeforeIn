//
//  BaseViewController.swift
//  BeforeIn
//
//  Created by t2023-m079 on 10/11/23.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
    
    
    // Alert
    func showAlertOneButton(title: String, message: String?, buttonTitle: String, completion: (() -> Void)? = nil) {
        
        let alertCotroller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonTitle, style: .default) { _ in
            completion?()
        }
        
        alertCotroller.addAction(action)
        
        present(alertCotroller, animated: true, completion: nil)
    
    }

    
    func showAlertTwoButton(title: String,
                            message: String?,
                            button1Title: String,
                            button2Title: String,
                            completion1: (() -> Void)? = nil,
                            completion2: (() -> Void)? = nil) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action1 = UIAlertAction(title: button1Title, style: .default) { _ in
            completion1?()
        }
        let action2 = UIAlertAction(title: button2Title, style: .default) { _ in
            completion2?()
        }
        
        alertController.addAction(action1)
        alertController.addAction(action2)
        
        present(alertController, animated: true, completion: nil)
    }
    
    // 루트뷰 변경, 화면 이동
    func transitionToRootView(view: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight

        self.view.window?.layer.add(transition, forKey: kCATransition)
        self.view.window?.rootViewController = view
    }
}
