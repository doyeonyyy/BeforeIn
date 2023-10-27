//
//  QuizIntroViewController.swift
//  BeforeIn
//
//  Created by t2023-m079 on 10/11/23.
//
import FirebaseDatabase
import FirebaseStorage
import Foundation
import UIKit
import SnapKit

class QuizIntroViewController: BaseViewController {
    var firebaseDB: DatabaseReference!
    
//    private var user = User(email: "dy@123.com", name: "김도연", nickname: "됸됸이", profileImage: UIImage(systemName: "person.fill")!, level: 1, phone: "")
    let quizIntroView = QuizIntroView()
    
    override func loadView() {
        view = quizIntroView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let quizIntroViewModel = QuizIntroViewModel(user: self.user)
        quizIntroView.quizIntroViewModel = QuizIntroViewModel(user: currentUser)

        quizIntroView.skipButton.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
        quizIntroView.startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
    }
    
    @objc func startButtonTapped(_ button: UIButton) {
        let startVC = NewQuizViewController()
        startVC.modalPresentationStyle = .fullScreen
        self.present(startVC, animated: true)
    }
    
    @objc func skipButtonTapped(_ button: UIButton) {
        self.dismiss(animated: true)
        let tapBarVC = TapbarController()
        transitionToRootView(view: tapBarVC)
    }
    
    
}
