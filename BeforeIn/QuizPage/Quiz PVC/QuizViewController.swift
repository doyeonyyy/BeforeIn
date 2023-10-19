//
//  QuizViewController.swift
//  BeforeIn
//
//  Created by t2023-m079 on 10/11/23.
//
import Firebase
import Foundation
import UIKit
import SnapKit

class QuizViewController: UIPageViewController {
    // Firebase 초기화
//    FirebaseApp.configure()

    // Firebase 데이터베이스 참조
//    let ref = Database.database().reference()

    private var previousButton: UIButton!
    private var cancelButton: UIButton!
    
    private var pages = [UIViewController]()
    private var initialPage = 0
    private var pageControl: UIPageControl!
    
    private var buttonO: UIButton!
    private var buttonX: UIButton!
    
    private var nextButton: UIButton!
    
    private var previousButtonConstraint: Constraint!
    private var cancelButtonConstraint: Constraint!
    private var buttonOConstraint: Constraint!
    private var buttonXConstraint: Constraint!
    private var nextButtonConstraint: Constraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPage()
        setupUI()
        setupLayout()
    }
    
//    private func setupPage() {
//        fetchRandomQuizQuestions { quizData in
//            self.pages.removeAll()
//
//            for (index, quiz) in quizData.enumerated() {
//                let quizPage = QuizContentsViewController(page: "\(index + 1)/\(quizData.count)", content: quiz.question)
//                self.pages.append(quizPage)
//            }
//
//            self.pageControl.numberOfPages = self.pages.count
//            self.setViewControllers([self.pages.first!], direction: .forward, animated: true, completion: nil)
//        }
//    }

//    func fetchRandomQuizQuestions(completion: @escaping ([Quiz]) -> Void) {
//        var quizArray: [Quiz] = []
//
//        // Firebase 데이터베이스에서 퀴즈 데이터 가져오기
//        ref.child("Etiquette").observeSingleEvent(of: .value) { (snapshot) in
//            if let data = snapshot.value as? [String: Bool] {
//                for (question, answer) in data {
//                    let quizItem = Quiz(question: question, answer: answer)
//                    quizArray.append(quizItem)
//                }
//
//                quizArray.shuffle()
//                let selectedQuiz = Array(quizArray.prefix(10))
//
//                completion(selectedQuiz)
//            }
//        }
//    }

    
    private func setupPage() {
        let page1 = QuizContentsViewController(page: "1/n", content: "문제1")
        let page2 = QuizContentsViewController(page: "2/n", content: "문제2")
        let page3 = QuizContentsViewController(page: "3/n", content: "문제3")
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
    }
//
//    // 퀴즈 데이터 가져오기
//    func fetchRandomQuizQuestions(completion: @escaping ([Quiz]) -> Void) {
//        var quizArray: [Quiz] = []
//
//        // Firebase 데이터베이스에서 퀴즈 데이터 가져오기
//        ref.child("quiz").observeSingleEvent(of: .value) { (snapshot) in
//            if let data = snapshot.value as? [String: Bool] {
//                for (question, answer) in data {
//                    // 퀴즈 데이터를 Quiz 모델로 변환
//                    let quizItem = Quiz(question: question, answer: answer)
//                    quizArray.append(quizItem)
//                }
//
//                // 랜덤으로 섞고 10개로 제한
//                quizArray.shuffle()
//                let selectedQuiz = Array(quizArray.prefix(10))
//
//                // 완료 후에 데이터를 반환
//                completion(selectedQuiz)
//            }
//        }
//    }
    
    
    private func setupUI() {
        self.dataSource = self
        self.delegate = self
        self.setViewControllers([pages[initialPage]], direction: .forward, animated: true)
        
        pageControl = UIPageControl()
        pageControl.numberOfPages = pages.count
        pageControl.currentPageIndicatorTintColor = .darkGray
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.backgroundColor = .systemBackground
        pageControl.addTarget(self, action: #selector(pageControlHandler), for: .valueChanged)
        
        previousButton = UIButton()
        previousButton.setTitle("이전 단계로", for: .normal)
        previousButton.setTitleColor(.black, for: .normal)
        previousButton.addTarget(self, action: #selector(buttonHandler), for: .touchUpInside)
        
        cancelButton = UIButton()
        cancelButton.setTitle("종료", for: .normal)
        cancelButton.setTitleColor(.black, for: .normal)
        cancelButton.addTarget(self, action: #selector(buttonHandler), for: .touchUpInside)
        
        buttonO = UIButton()
        buttonO.setImage(UIImage(named: "O"), for: .normal)
        
        buttonX = UIButton()
        buttonX.setImage(UIImage(named: "X"), for: .normal)
        
        nextButton = UIButton()
        nextButton.setTitle("다음", for: .normal)
        nextButton.setTitleColor(.black, for: .normal)
    }
    
    private func setupLayout() {
        view.addSubview(previousButton)
        previousButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(60)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(24)
        }
        
        view.addSubview(cancelButton)
        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(60)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(24)
        }
        
        view.addSubview(pageControl)
        pageControl.snp.makeConstraints { make in
            make.top.equalTo(previousButton.snp.bottom).offset(8)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        
        view.addSubview(buttonO)
        buttonO.snp.makeConstraints { make in
            make.width.height.equalTo(92)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(328)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(40)
        }
        
        view.addSubview(buttonX)
        buttonX.snp.makeConstraints { make in
            make.width.height.equalTo(162)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(296)
            make.leading.equalTo(buttonO.snp.trailing).offset(100)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(30.89)
        }
        
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(626)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
// MARK: - DataSource

extension QuizViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewContorller: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewContorller) else { return nil }
        guard currentIndex > 0 else { return nil }
        return pages[currentIndex - 1]
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        guard currentIndex < (pages.count - 1) else { return nil }
        return pages[currentIndex + 1]
    }
}

// MARK: - Delegate

extension QuizViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let viewControllers = pageViewController.viewControllers, let currentIndex = pages.firstIndex(of: viewControllers[0]) else { return }
        
        pageControl.currentPage = currentIndex
        //            animateButtonLayoutIfNeeded()
    }
}
// MARK: - Action
extension QuizViewController {
    @objc func buttonHandler(_ sender: UIButton) {
        switch sender.currentTitle {
        case "이전":
            goToPreviousPage()
            pageControl.currentPage -= 1
        case "취소":
            UserDefaults.standard.set(true, forKey: "Quiz")
            dismiss(animated: true)
        case "다음":
            goToNextPage()
            pageControl.currentPage += 1
            
        default: break
        }
        //            animateButtonLayoutIfNeeded()
    }
    @objc func pageControlHandler(_ sender: UIPageControl) {
        guard let currentViewController = viewControllers?.first,
              let currentIndex = pages.firstIndex(of: currentViewController) else { return }
        let direction: UIPageViewController.NavigationDirection = (sender.currentPage > currentIndex) ? .forward: .reverse
        self.setViewControllers([pages[sender.currentPage]], direction: direction, animated: true)
    }
}
// MARK: - Extension
extension QuizViewController {
    func goToPreviousPage() {
        guard let currentPage = viewControllers?[0],
              let previousPage = self.dataSource?.pageViewController(self, viewControllerBefore: currentPage) else { return }
        self.setViewControllers([previousPage], direction: .reverse, animated: true)
    }
    func goToNextPage() {
        guard let currentPage = viewControllers?[0],
              let nextPage = self.dataSource?.pageViewController(self, viewControllerAfter: currentPage) else { return }
        self.setViewControllers([nextPage], direction: .forward, animated: true)
    }
    func goToSpecificPage(index: Int) {
        self.setViewControllers([pages[index]], direction: .forward, animated: true)
    }
    //        private func animateButtonLayoutIfNeeded() {
    //            if pageControl.currentPage == (pages.count - 1) {
    //                hideButtons()
    //            } else {
    //                showButtons()
    //            }
    //
    //            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: .zero, animations: .curveEaseOut) {
    //                self.view.layoutIfNeeded()
    //            }
    //        }
    //        private func showButtons() {}
    //        private func hideButtons() {}
}
