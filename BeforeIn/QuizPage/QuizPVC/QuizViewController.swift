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
    private var buttonO: UIButton!
    private var buttonX: UIButton!
    private var nextButton: UIButton!
    
    private var pages = [UIViewController]()
    private var initialPage = 0
    
    private var pageControl: UIPageControl!
    
    private var previousButtonConstraint: Constraint!
    private var cancelButtonConstraint: Constraint!
    private var buttonOConstraint: Constraint!
    private var buttonXConstraint: Constraint!
    private var nextButtonTopConstraint: Constraint!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPage()
        setupUI()
        setupLayout()
    }
    
    private func setupPage() {
        let page1 = QuizContentsViewController(contentLabel: "1")
        let page2 = QuizContentsViewController(contentLabel: "2")
        let page3 = QuizContentsViewController(contentLabel: "3")
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
        previousButton.setTitle("이전으로", for: .normal)
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
        nextButton.addTarget(self, action: #selector(buttonHandler), for: .touchUpInside)
    }
    
    private func setupLayout() {
        view.addSubview(previousButton)
        previousButton.snp.makeConstraints { make in
            previousButtonConstraint = make.top.equalTo(view.safeAreaLayoutGuide).offset(60).constraint; make.leading.equalTo(view.safeAreaLayoutGuide).offset(24)
        }
        
        view.addSubview(cancelButton)
        cancelButton.snp.makeConstraints { make in
            cancelButtonConstraint = make.top.equalTo(view.safeAreaLayoutGuide).offset(60).constraint; make.trailing.equalTo(view.safeAreaLayoutGuide).inset(24)
        }
        
        view.addSubview(buttonO)
        buttonO.snp.makeConstraints { make in
            buttonOConstraint = make.width.height.equalTo(92).constraint; make.top.equalTo(view.safeAreaLayoutGuide).offset(328); make.leading.equalTo(view.safeAreaLayoutGuide).offset(40)
        }
        
        view.addSubview(buttonX)
        buttonX.snp.makeConstraints { make in
            buttonXConstraint = make.width.height.equalTo(92).constraint; make.top.equalTo(view.safeAreaLayoutGuide).offset(328); make.trailing.equalTo(view.safeAreaLayoutGuide).inset(40)
        }
    }
}

/*

let pagesLabel = UILabel()
pagesLabel.text = "1/10"
pagesLabel.textColor = .black
pagesLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 18)
view.addSubview(pagesLabel)
pagesLabel.snp.makeConstraints { make in
    make.top.equalTo(view.safeAreaLayoutGuide).offset(116)
    make.centerX.equalTo(view.safeAreaLayoutGuide)
}
 */

// MARK: - DataSource

extension QuizViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        guard currentIndex > 0 else { return nil }
        return pages[currentIndex - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
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
        animateButtonLayoutIfNeeded()
    }
}

// MARK: - Action

extension QuizViewController {
    @objc func buttonHandler(_ sender: UIButton) {
        switch sender.currentTitle {
        case "이전으로": goToPreviousPage()
            pageControl.currentPage -= 1
        case "종료": UserDefaults.standard.set(true, forKey: "Quiz")
        case "다음": goToNextPage()
            pageControl.currentPage += 1
            
        default: break
        }
        
        animateButtonLayoutIfNeeded()
    }
    
    @objc func pageControlHandler(_ sender: UIPageControl) {
        guard let currentViewController = viewControllers?.first, let currentIndex = pages.firstIndex(of: currentViewController) else { return }
        
        let direction: UIPageViewController.NavigationDirection = (sender.currentPage > currentIndex) ? .forward : .reverse
        self.setViewControllers([pages[sender.currentPage]], direction: direction, animated: true)
    }
}

// MARK: - Extension
extension QuizViewController {
    func goToPreviousPage() {
        guard let currentPage = viewControllers?[0], let previousPage = self.dataSource?.pageViewController(self, viewControllerAfter: currentPage) else { return }
        
        self.setViewControllers([previousPage], direction: .reverse, animated: true)
    }
    
    func goToNextPage() {
        guard let currentPage = viewControllers?[0], let nextPage = self.dataSource?.pageViewController(self, viewControllerAfter: currentPage) else { return }
        
        self.setViewControllers([nextPage], direction: .forward, animated: true)
    }
    
    func goToSpecificPage(index: Int) {
        self.setViewControllers([pages[index]], direction: .forward, animated: true)
    }
    
    private func animateButtonLayoutIfNeeded() {
        if pageControl.currentPage == (pages.count - 1) {
            hideButtons()
        } else {
            showButtons()
        }
        
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: .zero, options: .curveEaseOut) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func showButtons() {
        previousButtonConstraint.update(offset: 0)
        cancelButtonConstraint.update(offset: 0)
    }
    
    private func hideButtons() {
        previousButtonConstraint.update(offset: -100)
        cancelButtonConstraint.update(offset: -100)
    }
}
