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
    
    private var user = User(email: "dy@123.com", name: "김도연", nickname: "됸됸이", profileImage: UIImage(systemName: "person.fill")!, level: 1, phone: "")
    let quizIntroView = QuizIntroView()
    
    override func loadView() {
        view = quizIntroView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let quizIntroViewModel = QuizIntroViewModel(user: self.user)
        quizIntroView.quizIntroViewModel = quizIntroViewModel

        quizIntroView.skipButton.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
        quizIntroView.startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
    }
    
    @objc func startButtonTapped(_ button: UIButton) {
        let startVC = QuizViewController()
        startVC.modalPresentationStyle = .fullScreen
        self.present(startVC, animated: true)
    }
    @objc func skipButtonTapped(_ button: UIButton) {
        let skipVC = MainViewController()
        skipVC.modalPresentationStyle = .fullScreen
        self.present(skipVC, animated: true)
    }
}
