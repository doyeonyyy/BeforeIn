//
//  QuizResultViewController.swift
//  BeforeIn
//
//  Created by t2023-m0047 on 2023/10/13.
//
import SnapKit
import Then
import UIKit

class QuizResultViewController: UIViewController {

    
    let quizResultView = QuizResultView()
    
    override func loadView() {
        view = quizResultView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let quizResultViewModel = QuizResultViewModel(user: currentUser)
        quizResultView.quizResultViewModel = quizResultViewModel
        quizResultView.startButton.addTarget(self, action: #selector(startButtonClick), for: .touchUpInside)
    }
    private func updateView() {
        print("View 업데이트")
    }
    
    @objc func startButtonClick() {
        if let rootViewController = UIApplication.shared.keyWindow?.rootViewController {
            rootViewController.dismiss(animated: true, completion: nil)
        }
    }
}
