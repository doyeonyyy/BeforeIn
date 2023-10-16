//
//  QuizViewController.swift
//  BeforeIn
//
//  Created by t2023-m079 on 10/11/23.
//
import Foundation
import UIKit
import SnapKit

class QuizViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cancelButton = UIButton()
        cancelButton.setTitle("취소", for: .normal)
        cancelButton.setTitleColor(.black, for: .normal)
        view.addSubview(cancelButton)
        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(60)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(24)
        }
        
        let pagesLabel = UILabel()
        pagesLabel.text = "1/10"
        pagesLabel.textColor = .black
        pagesLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 18)
        view.addSubview(pagesLabel)
        pagesLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(116)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        
        let buttonO = UIButton()
        buttonO.setImage(UIImage(named: "O"), for: .normal)
        view.addSubview(buttonO)
        buttonO.snp.makeConstraints { make in
            make.width.height.equalTo(92)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(328)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(40)
        }
        
        let buttonX = UIButton()
        buttonX.setImage(UIImage(named: "X"), for: .normal)
        view.addSubview(buttonX)
        buttonX.snp.makeConstraints { make in
            make.width.height.equalTo(162)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(296)
            make.leading.equalTo(buttonO.snp.trailing).offset(100)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(30.89)
        }
        
        let previousButton = UIButton()
        previousButton.setTitle("이전", for: .normal)
        previousButton.setTitleColor(.gray, for: .normal)
        view.addSubview(previousButton)
        previousButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(626)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(40)
        }
        
        let continueButton = UIButton()
        continueButton.setTitle("다음", for: .normal)
        continueButton.setTitleColor(.black, for: .normal)
        view.addSubview(continueButton)
        continueButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(626)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(40)
        }
    }
}
