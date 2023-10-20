//
//  QuizViewController.swift
//  BeforeIn
//
//  Created by t2023-m079 on 10/11/23.
//
import FirebaseDatabase
import Foundation
import UIKit
import SnapKit

class QuizViewController: UIPageViewController {
    var firebaseDB: DatabaseReference!
    
    let ref = Database.database().reference()
    
    private var previousButton: UIButton?
    private var cancelButton: UIButton?
    private var progressView = UIProgressView(progressViewStyle: .default)
    
    private var buttonO: UIButton?
    private var buttonX: UIButton?
    private var nextButton: UIButton?
    
    private var pages = [QuizContentsViewController]()
    //    private var pages = [UIViewController]() // 1. 'pages' 배열 선언 및 초기화
    private var currentPageIndex = 0
    var userAnswers = [UserAnswer]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
        setupPage()
        
        previousButton?.addTarget(self, action: #selector(goToPreviousPage), for: .touchUpInside)
        cancelButton?.addTarget(self, action: #selector(buttonHandler), for: .touchUpInside)
        nextButton?.addTarget(self, action: #selector(goToNextPage), for: .touchUpInside)
    }
    
    private func setupPage() {
        fetchRandomQuizQuestions { quizData in
            self.pages.removeAll()
            
            for (index, quiz) in quizData.enumerated() {
                let quizPage = QuizContentsViewController(page: "\(index + 1)/\(quizData.count)", content: quiz.question, answer: quiz.answer)
                self.pages.append(quizPage)
            }
            
            if let initialPage = self.pages.first {
                self.setViewControllers([initialPage], direction: .forward, animated: true, completion: nil)
            }
        }
    }
    
    func fetchRandomQuizQuestions(completion: @escaping ([Quiz]) -> Void) {
        var quizArray: [Quiz] = []
        
        // Firebase 데이터베이스에서 퀴즈 데이터 가져오기
        ref.child("savedData/Quiz/place/결혼식/").observeSingleEvent(of: .value) { (snapshot) in
            if let data = snapshot.value as? [String: String] {
                for (question, answer) in data {
                    let quizItem = Quiz(question: question, answer: answer)
                    quizArray.append(quizItem)
                }
                
                quizArray.shuffle()
                let selectedQuiz = Array(quizArray.prefix(10))
                
                completion(selectedQuiz)
            }
        }
    }
    
    private func setupUI() {
        
        progressView = UIProgressView()
        progressView.progress = 0.0
        // 처음에는 previousButton을 숨김
        previousButton?.isHidden = true
        previousButton = UIButton()
        cancelButton = UIButton()
        buttonO = UIButton()
        buttonX = UIButton()
        nextButton = UIButton()
        
        self.dataSource = self
        self.delegate = self
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(previousButton!)
        view.addSubview(cancelButton!)
        view.addSubview(progressView)
        view.addSubview(buttonO!)
        view.addSubview(buttonX!)
        view.addSubview(nextButton!)
        
        
        progressView.tintColor = UIColor.BeforeInRed
        
        previousButton?.setTitle("이전 단계로", for: .normal)
        previousButton?.setTitleColor(.black, for: .normal)
        
        cancelButton?.setTitle("종료", for: .normal)
        cancelButton?.setTitleColor(.black, for: .normal)
        
        buttonO?.setImage(UIImage(named: "O"), for: .normal)
        buttonX?.setImage(UIImage(named: "X"), for: .normal)
        
        nextButton?.setTitle("다음", for: .normal)
        nextButton?.setTitleColor(.black, for: .normal)
    }
    
    private func setupLayout() {
        
        previousButton?.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(60)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(24)
            make.width.height.equalTo(30)
        }
        
        cancelButton?.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(60)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(24)
        }
        
        progressView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(8)
            make.centerX.equalTo(view)
        }
        
        buttonO?.snp.makeConstraints { make in
            make.width.height.equalTo(92)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(328)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(40)
        }
        
        buttonX?.snp.makeConstraints { make in
            make.width.height.equalTo(162)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(296)
            make.leading.equalTo((buttonO?.snp.trailing)!).offset(100)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(30.89)
        }
        
        nextButton?.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(626)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
        }
    }
    @objc func oButtonTapped(_ sender: UIButton) {
        buttonX?.setImage(UIImage(named: "inactiveX"), for: .normal)
        buttonO?.setImage(UIImage(named: "O"), for: .normal)
        print("'O'를 선택하였습니다.")
    }

    @objc func xButtonTapped(_ sender: UIButton) {
        buttonO?.setImage(UIImage(named: "inactiveO"), for: .normal)
        buttonX?.setImage(UIImage(named: "X"), for: .normal)
        print("'X'를 선택하였습니다.")
    }

    @objc func optionButtonTapped(_ sender: UIButton) {
        let selectedOption = sender.tag == 0 ? "O" : "X"
        
        // 현재 질문에 대한 정답 확인
        let currentQuestion = pages[currentPageIndex]
        let isCorrect = (selectedOption == currentQuestion.answer)
        
        // 사용자 답변 저장
        let userAnswer = UserAnswer(isCorrect: isCorrect, selectedOption: selectedOption)
        userAnswers.append(userAnswer)
        
        // 다음 페이지로 이동
        currentPageIndex += 1
        if currentPageIndex < pages.count {
            let nextQuestion = pages[currentPageIndex]
            setViewControllers([nextQuestion], direction: .forward, animated: true, completion: nil)
        } else {
            // 마지막 페이지에 도달했을 때, 점수 및 결과 페이지 표시
            showResultPage()
        }
    }
    @objc func showResultPage() {
//        self.present(QuizResultViewController, animated: true, completion: nil)
    }
}

// MARK: - DataSource

extension QuizViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewContorller: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewContorller as! QuizContentsViewController) else { return nil }
        guard currentIndex > 0 else { return nil }
        return pages[currentIndex - 1]
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController as! QuizContentsViewController) else { return nil }
        guard currentIndex < (pages.count - 1) else { return nil }
        return pages[currentIndex + 1]
    }
}
// MARK: - Delegate
extension QuizViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let viewControllers = pageViewController.viewControllers,
              let currentIndex = pages.firstIndex(of: viewControllers[0] as! QuizContentsViewController) else { return }
        
        // 페이지의 진행률을 설정합니다.
        let totalPageCount = pages.count - 1
        let currentPage = Float(currentIndex)
        let progress = currentPage / Float(totalPageCount)
        progressView.setProgress(progress, animated: true)
        
        animateButtonLayoutIfNeeded()
    }
}
// MARK: - Action
extension QuizViewController {
    @objc func buttonHandler(_ sender: UIButton) {
        switch sender.currentTitle {
        case "이전 단계로":
            goToPreviousPage()
        case "종료":
            // 앱을 종료하는 작업을 수행합니다.
            dismiss(animated: true, completion: nil)
        case "다음":
            goToNextPage()
        default: break
        }
        animateButtonLayoutIfNeeded()
    }
    
    @objc func pageControlHandler(_ sender: UIPageControl) {
        // 페이지 컨트롤이 변경될 때, 선택한 페이지로 이동합니다.
        let selectedPageIndex = sender.currentPage
        goToSpecificPage(index: selectedPageIndex)
    }
}
// MARK: - Extension
extension QuizViewController {
    @objc func goToPreviousPage() {
        guard let currentPage = viewControllers?[0],
              let previousPage = self.dataSource?.pageViewController(self, viewControllerBefore: currentPage) else { return }
        self.setViewControllers([previousPage], direction: .reverse, animated: true)
    }
    
    @objc func goToNextPage() {
        guard let currentPage = viewControllers?[0],
              let nextPage = self.dataSource?.pageViewController(self, viewControllerAfter: currentPage) else { return }
        self.setViewControllers([nextPage], direction: .forward, animated: true)
    }
    
    func goToSpecificPage(index: Int) {
        self.setViewControllers([pages[index]], direction: .forward, animated: true)
    }
    
    private func animateButtonLayoutIfNeeded() {
        if progressView.progress == 1.0 {
            hideButtons()
        } else {
            showButtons()
            // currentPageIndex가 0인 경우 previousButton을 숨깁니다.
            previousButton?.isHidden = (currentPageIndex == 0)
        }
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func showButtons() {}
    private func hideButtons() {}
}
