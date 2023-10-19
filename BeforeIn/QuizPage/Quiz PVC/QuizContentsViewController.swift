//
//  QuizContentsViewController.swift
//  BeforeIn
//
//  Created by t2023-m0047 on 2023/10/16.
//

import UIKit

class QuizContentsViewController: UIViewController {
    
    private var stackView: UIStackView!
    
    private var quizPage = UILabel()
    // progress bar 삽입할 공간
    private var quizContent = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
    }
    
    init(page: String, content: String) {
        super.init(nibName: nil, bundle: nil)
        quizPage.text = page
        quizContent.text = content
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        quizPage.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 18)
        quizPage.textAlignment = .center
        quizPage.numberOfLines = 0
        
        quizContent.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 24)
        quizContent.textAlignment = .center
        quizContent.numberOfLines = 0
        
        self.stackView = UIStackView(arrangedSubviews: [quizPage, quizContent])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .center
    }
    
    private func setupLayout() {
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(85)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(100)
        }
    }
}
