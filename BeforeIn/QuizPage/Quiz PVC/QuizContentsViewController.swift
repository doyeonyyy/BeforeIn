//
//  QuizContentsViewController.swift
//  BeforeIn
//
//  Created by t2023-m0047 on 2023/10/16.
//

import UIKit

class QuizContentsViewController: UIViewController {
    
    private var stackView: UIStackView!
    private var quizPageLabel: UILabel!
    private var quizContentLabel: UILabel!
    
    var answer: String // 정답을 저장할 속성
    
    init(page: String, content: String, answer: String) {
        self.answer = answer // 정답을 설정
        
        super.init(nibName: nil, bundle: nil)
        
        quizPageLabel = UILabel()
        quizContentLabel = UILabel()
        
        quizPageLabel.text = page
        quizContentLabel.text = content
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        quizPageLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 18)
        quizPageLabel.textAlignment = .center
        quizPageLabel.numberOfLines = 0
        
        quizContentLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 24)
        quizContentLabel.textAlignment = .center
        quizContentLabel.numberOfLines = 0
        
        stackView = UIStackView(arrangedSubviews: [quizPageLabel, quizContentLabel])
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
