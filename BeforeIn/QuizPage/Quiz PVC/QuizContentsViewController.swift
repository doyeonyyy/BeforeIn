//
//  QuizContentsViewController.swift
//  BeforeIn
//
//  Created by t2023-m0047 on 2023/10/16.
//

import UIKit
import SnapKit
import Then

class NewQuizContentViewController: UIViewController {
    
    private var question: String
    private var answer: Bool
    private var index: Int
    private var userAnswer: Bool?
    private var isCorrect: Bool?
    private var buttonO: UIButton!
    private var buttonX: UIButton!
    var nextButton: UIButton!
    var previousButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        checkIndex()
    }
    
    init(question: String, answer: Bool, index: Int) {
        self.question = question
        self.answer = answer
        self.index = index
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        let cancelButton = UIButton().then {
            $0.setTitle("취소하기", for: .normal)
            $0.setTitleColor(.black, for: .normal)
            $0.addTarget(self, action: #selector(cancelButtonClick), for: .touchUpInside)
        }
        
        let progressLabel = UILabel().then {
            $0.text = "\(self.index)/10"
            $0.textColor = .black
        }
        
        let quizLabel = UILabel().then {
            $0.text = "\(self.question) 정답 : \(self.answer)"
            $0.numberOfLines = 0
            $0.font = UIFont.systemFont(ofSize: 24)
        }
        
        let buttonO = UIButton().then {
            let configuration = UIImage.SymbolConfiguration(scale: .large)
            let normalImage = UIImage(named: "QuizInactiveO")?.withConfiguration(configuration)
            let selectedImage = UIImage(named: "QuizActiveO")?.withConfiguration(configuration)

            $0.configuration = .filled()
            $0.showsMenuAsPrimaryAction = false
            $0.setImage(normalImage, for: .normal)
            $0.setImage(selectedImage, for: .selected)
            $0.addTarget(self, action: #selector(oButtonClick), for: .touchUpInside)
            $0.tintColor = .clear
            
            self.buttonO = $0
        }
        let buttonX = UIButton().then {
            let configuration = UIImage.SymbolConfiguration(scale: .large)
            let normalImage = UIImage(named: "QuizInactiveX")?.withConfiguration(configuration)
            let selectedImage = UIImage(named: "QuizActiveX")?.withConfiguration(configuration)

            $0.configuration = .filled()
            $0.showsMenuAsPrimaryAction = false
            $0.setImage(normalImage, for: .normal)
            $0.setImage(selectedImage, for: .selected)
            $0.addTarget(self, action: #selector(xButtonClick), for: .touchUpInside)
            $0.tintColor = .clear
            
            self.buttonX = $0
        }
        
        let nextButton = UIButton().then {
            $0.setTitle("다음", for: .normal)
            $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
            $0.setTitleColor(.black, for: .normal)
            $0.addTarget(self, action: #selector(nextButtonClick), for: .touchUpInside)
            self.nextButton = $0
        }
        
        let previousButton = UIButton().then {
            $0.setTitle("이전", for: .normal)
            $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
            $0.setTitleColor(.black, for: .normal)
            $0.addTarget(self, action: #selector(previousButtonClick), for: .touchUpInside)
            self.previousButton = $0
        }
        
        view.addSubview(cancelButton)
        view.addSubview(progressLabel)
        view.addSubview(quizLabel)
        view.addSubview(buttonO)
        view.addSubview(buttonX)
        view.addSubview(nextButton)
        view.addSubview(previousButton)
        
        
        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.trailing.equalToSuperview().inset(20)
        }
        
        progressLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(cancelButton.snp.bottom).offset(45)
        }
        
        quizLabel.snp.makeConstraints { make in
            make.top.equalTo(progressLabel.snp.bottom).offset(60)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().inset(24)
        }
        buttonO.snp.makeConstraints { make in
            make.top.equalTo(quizLabel.snp.bottom).offset(100)
            make.width.height.equalTo(92)
            make.leading.equalToSuperview().offset(40)
        }
        buttonX.snp.makeConstraints { make in
            make.top.equalTo(quizLabel.snp.bottom).offset(100)
            make.width.height.equalTo(92)
            make.trailing.equalToSuperview().inset(40)
        }
        previousButton.snp.makeConstraints { make in
            make.centerX.equalTo(buttonO)
            make.top.equalTo(buttonX.snp.bottom).offset(190)
        }
        nextButton.snp.makeConstraints { make in
            make.centerX.equalTo(buttonX)
            make.top.equalTo(buttonX.snp.bottom).offset(190)
        }
        
    }
    
    func checkIndex() {
        if index == 1 {
            previousButton.isHidden = true
            nextButton.snp.remakeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(buttonX.snp.bottom).offset(190)
            }
        }
        if index == 10 {
            nextButton.setTitle("완료", for: .normal)
        }
    }
    
    @objc func cancelButtonClick() {
        self.dismiss(animated: true)
    }
    
    @objc func oButtonClick(_ sender: UIButton) {
        sender.isSelected.toggle()
        if self.buttonX.isSelected {
            buttonX.isSelected.toggle()
        }
        if sender.isSelected {
            userAnswer = true
        }
        else {
            userAnswer = nil
        }
    }
    
    @objc func xButtonClick(_ sender: UIButton) {
        sender.isSelected.toggle()
        if self.buttonO.isSelected {
            buttonO.isSelected.toggle()
        }
        if sender.isSelected {
            userAnswer = false
        }
        else {
            userAnswer = nil
        }
    }
    
    @objc func previousButtonClick() {
        goToPreviousPage()
    }
    
    @objc func nextButtonClick() {

        if let userAnswer = userAnswer {
            if userAnswer == self.answer {
                isCorrect = true
                print("정답")
                goToNextPage()
            }
            else {
                isCorrect = false
                print("오답")
                goToNextPage()
            }
        }
        else {
            isCorrect = nil
            print("선택안함")
        }
    }
    
    
    private func goToNextPage() {
        if index == 3 {
            var count = 0
            if let parentViewController = parent as? NewQuizViewController {
                for parentVC in parentViewController.orderedViewControllers {
                    if parentVC.isCorrect == true {
                        count += 1
                    }
                }
            }
            switch count {
            case 0: currentUser.level = 1
            case 1: currentUser.level = 2
            case 2: currentUser.level = 3
            case 3: currentUser.level = 4
            default: currentUser.level = 5
            }
            
            let resultVC = QuizResultViewController()
            resultVC.modalPresentationStyle = .fullScreen
            present(resultVC, animated: true)
        }
        else {
            if let parentViewController = parent as? NewQuizViewController {
                parentViewController.goToNextPage()
            }
        }
        
    }
    
    private func goToPreviousPage() {
        if let parentViewController = parent as? NewQuizViewController {
            parentViewController.goToPreviousPage()
        }
    }

}
