//
//  QuizViewController.swift
//  BeforeIn
//
//  Created by t2023-m079 on 10/11/23.
//
import Foundation
import UIKit
import SnapKit

class QuizViewController: UIPageViewController {
    
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
    
    private func setupPage() {
        let page1 = QuizContentsViewController(page: "1/n", content: "문제1")
        let page2 = QuizContentsViewController(page: "2/n", content: "문제2")
        let page3 = QuizContentsViewController(page: "3/n", content: "문제3")
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
    }
    
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
