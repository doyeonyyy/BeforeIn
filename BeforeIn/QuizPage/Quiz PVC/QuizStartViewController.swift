//
//  QuizStartViewController.swift
//  BeforeIn
//
//  Created by t2023-m0047 on 2023/10/16.
//

import UIKit

class QuizStartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
    
    func checkQuizRun() {
        let userDefault = UserDefaults.standard
        if userDefault.bool(forKey: "Quiz") == false {
            let quizVC = QuizViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
            quizVC.modalPresentationStyle = .fullScreen
            present(quizVC, animated: false)
        }
    }
}
