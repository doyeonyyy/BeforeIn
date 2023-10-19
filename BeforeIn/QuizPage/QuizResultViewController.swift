//
//  QuizResultViewController.swift
//  BeforeIn
//
//  Created by t2023-m0047 on 2023/10/13.
//
import FirebaseDatabase
import FirebaseStorage
import Gifu
import SnapKit
import Then
import UIKit

class QuizResultViewController: UIViewController {
   
    var firebaseDB: DatabaseReference!
    
    private var user = User(email: "dy@123.com", name: "김도연", nickname: "됸됸이", profileImage: UIImage(systemName: "person.fill")!, level: 1, phone: "")
    
    let quizResultView = QuizResultView()
    
    override func loadView() {
        view = quizResultView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let quizResultViewModel = QuizResultViewModel(user: self.user)
        quizResultView.quizResultViewModel = quizResultViewModel

    }
    private func updateView() {
        print("View 업데이트")
    }
}
