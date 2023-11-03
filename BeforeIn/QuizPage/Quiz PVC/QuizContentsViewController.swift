//
//  QuizContentsViewController.swift
//  BeforeIn
//
//  Created by t2023-m0047 on 2023/10/16.
//

import UIKit
import SnapKit
import Then
import FirebaseAuth
import FirebaseFirestore

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
    let isDarkMode = UserDefaults.standard.bool(forKey: "isDarkMode")
    
    
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
            $0.setTitle("돌아가기", for: .normal)
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            $0.setTitleColor(.systemBlack, for: .normal)
            $0.addTarget(self, action: #selector(cancelButtonClick), for: .touchUpInside)
        }
        
        let progressLabel = UILabel().then {
            $0.text = "\(self.index)/10"
            $0.font = UIFont.systemFont(ofSize: 12)
        }
        
        let quizLabel = UILabel().then {
            $0.text = "\(self.question)."
            $0.numberOfLines = 0
            $0.font = UIFont(name: "SUITE-Medium", size: 18)
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
            $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
            $0.setTitleColor(.systemGray, for: .normal)
            $0.addTarget(self, action: #selector(nextButtonClick), for: .touchUpInside)
            self.nextButton = $0
        }
        
        let previousButton = UIButton().then {
            $0.setTitle("이전", for: .normal)
            $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
            if isDarkMode {
                $0.setTitleColor(.white, for: .normal)
            }
            else {
                $0.setTitleColor(.black, for: .normal)
            }
            
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
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.trailing.equalToSuperview().inset(24)
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
            make.centerY.equalToSuperview().offset(60)
            make.width.height.equalTo(92)
            make.leading.equalToSuperview().offset(50)
        }
        buttonX.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(60)
            make.width.height.equalTo(92)
            make.trailing.equalToSuperview().inset(50)
        }
        previousButton.snp.makeConstraints { make in
            make.centerX.equalTo(buttonO)
            make.bottom.equalToSuperview().offset(-80)
        }
        nextButton.snp.makeConstraints { make in
            make.centerX.equalTo(buttonX)
            make.bottom.equalToSuperview().offset(-80)
        }
        
    }
    
    func checkIndex() {
        if index == 1 {
            previousButton.isHidden = true
            nextButton.snp.remakeConstraints { make in
                make.centerX.equalToSuperview()
                make.bottom.equalToSuperview().offset(-80)
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
            if isDarkMode {
                nextButton.setTitleColor(.white, for: .normal)
            }
            else {
                nextButton.setTitleColor(.black, for: .normal)
            }
           
        }
        else {
            userAnswer = nil
            nextButton.setTitleColor(.lightGray, for: .normal)
        }
    }
    
    @objc func xButtonClick(_ sender: UIButton) {
        sender.isSelected.toggle()
        if self.buttonO.isSelected {
            buttonO.isSelected.toggle()
        }
        if sender.isSelected {
            userAnswer = false
            if isDarkMode {
                nextButton.setTitleColor(.white, for: .normal)
            }
            else {
                nextButton.setTitleColor(.black, for: .normal)
            }
        }
        else {
            userAnswer = nil
            nextButton.setTitleColor(.lightGray, for: .normal)
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
            UIView.animate(withDuration: 0.05, animations: {
                self.buttonX.transform = CGAffineTransform(translationX: -10, y: 0)
                self.buttonO.transform = CGAffineTransform(translationX: -10, y: 0)
            }) { _ in
                UIView.animate(withDuration: 0.05, animations: {
                    self.buttonX.transform = CGAffineTransform(translationX: 20, y: 0)
                    self.buttonO.transform = CGAffineTransform(translationX: 20, y: 0)
                }) { _ in
                    self.buttonX.transform = .identity
                    self.buttonO.transform = .identity
                }
            }
            print("선택안함")
        }
    }
    
    
    private func goToNextPage() {
        if index == 10 {
            var count = 0
            if let parentViewController = parent as? NewQuizViewController {
                for parentVC in parentViewController.orderedViewControllers {
                    if parentVC.isCorrect == true {
                        count += 1
                    }
                }
            }
            switch count {
            case 0,1,2: currentUser.level = 1
            case 3,4,5: currentUser.level = 2
            case 5,6,7: currentUser.level = 3
            case 8,9: currentUser.level = 4
            default: currentUser.level = 5
            }
            changeUserLevel(currentUser.level)
                        
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
    
    private func changeUserLevel(_ count: Int) {
        let userEmail = Auth.auth().currentUser?.email
        let userCollection = Firestore.firestore().collection("User")
        userCollection.whereField("email", isEqualTo: userEmail).getDocuments { (querySnapshot, error) in
            if let error = error {
                print("에러: \(error.localizedDescription)")
            } else if let documents = querySnapshot?.documents, !documents.isEmpty {
                let userDocument = documents[0]
                userDocument.reference.updateData(["level": count]) { error in
                    if let error = error {
                        print("레벨 변경 실패: \(error.localizedDescription)")
                    } else {
                        print("레벨 변경 성공: \(count)")
                        currentUser.level = count
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
        }
        
    }
    
    private func goToPreviousPage() {
        if let parentViewController = parent as? NewQuizViewController {
            parentViewController.goToPreviousPage()
        }
    }

}
