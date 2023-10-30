//
//  QuizResultViewController.swift
//  BeforeIn
//
//  Created by t2023-m0047 on 2023/10/13.
//
import SnapKit
import Then
import UIKit

class QuizResultViewController: BaseViewController {

    
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
        print("startButtonClick")
        if let rootViewController = UIApplication.shared.keyWindow?.rootViewController {
            print(rootViewController)
            if let tabBarController = rootViewController as? UITabBarController {
                // 루트뷰가 탭 바 컨트롤러인 경우
                tabBarController.dismiss(animated: true, completion: nil)
            } else if let loginViewController = rootViewController as? UINavigationController {
                // 루트뷰가 로그인 뷰 컨트롤러인 경우
                self.dismiss(animated: true)
                let tapBarController = TapbarController()
                transitionToRootView(view: tapBarController)
            }
        }
    }
    


}
