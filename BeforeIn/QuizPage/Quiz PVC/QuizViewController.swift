//
//  QuizViewController.swift
//  BeforeIn
//
//  Created by t2023-m079 on 10/11/23.
//
import UIKit
import SnapKit
import Then
import FirebaseDatabase

class NewQuizViewController: UIPageViewController {
    var ref: DatabaseReference!
    var quizList: [Quiz] = []
    
    lazy var orderedViewControllers: [NewQuizContentViewController] = {
        var orderedViewControllers: [NewQuizContentViewController] = []
        var index = 1
        for quiz in quizList{
            let newQuizContentViewController = NewQuizContentViewController(question: quiz.question, answer: quiz.answer, index: index)
            orderedViewControllers.append(newQuizContentViewController)
            index += 1
        }
        return orderedViewControllers
    }()
    
    var currentIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        fetchQuizList()
        setupUI()
        disableGesture()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
    }
    
    @objc func nextButtonClick() {
        //        goToNextPage()
        print("다음 버튼 눌림")
    }
    
    func fetchQuizList() {
        ref = Database.database().reference()
        ref.child("SavedData/QuizData/").getData(completion:  { error, snapshot in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            var availableQuizzes: [Quiz] = []
            let data = snapshot?.value as! [String: Any]
        loop: for place in data.keys{
            let quizJson = data[place] as! [String: Any]
            let quizContent = quizJson["content"] as! [String: Bool]
            for quiz in quizContent.keys{
                let quiz = quiz
                let answer = quizContent[quiz] as! Bool
                availableQuizzes.append(Quiz(question: quiz, answer: answer))
            }
        }
            
            let numberofQuiz = 10
            if availableQuizzes.count > 10 {
                let randomIndexes = Array(0..<availableQuizzes.count).shuffled().prefix(numberofQuiz)
                self.quizList = randomIndexes.map { availableQuizzes[$0] }
            }
            else {
                self.quizList = availableQuizzes
            }
            
            if let firstViewController = self.orderedViewControllers.first {
                self.setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
            }
            print("\(self.quizList.count)")
        })
    }
    
    private func disableGesture() {
        if let gestureRecognizers = self.view.gestureRecognizers {
            for gesture in gestureRecognizers {
                gesture.isEnabled = false
            }
        }
    }
    
}

extension NewQuizViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController as! NewQuizContentViewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        if previousIndex < 0 {
            return nil
        }
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController as! NewQuizContentViewController) else {
            return nil
        }
        let nextIndex = viewControllerIndex + 1
        if nextIndex >= orderedViewControllers.count {
            //마지막페이지 로직 넣어주자
            return nil
        }
        return orderedViewControllers[nextIndex]
    }
    
    func goToNextPage() {
        if let currentViewController = viewControllers?.first,
           let nextViewController = dataSource?.pageViewController(self, viewControllerAfter: currentViewController) {
            setViewControllers([nextViewController], direction: .forward, animated: false)
        }
    }
    
    func goToPreviousPage() {
        if let currentViewController = viewControllers?.first,
           let previousViewController = dataSource?.pageViewController(self, viewControllerBefore: currentViewController) {
            setViewControllers([previousViewController], direction: .reverse, animated: false)
        }
    }
    
}
