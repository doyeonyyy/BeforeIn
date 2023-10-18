//
//  QuizIntroViewController.swift
//  BeforeIn
//
//  Created by t2023-m079 on 10/11/23.
//
import Foundation
import UIKit
import SnapKit

class QuizIntroViewController: BaseViewController {
    
    let labelA = UILabel()
    let labelB = UILabel()
    let labelC = UILabel()
    let labelD = UILabel()
    
    let imageView = UIImageView()

    let skipButton = UIButton()
    let startButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        skipButton.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        
        labelA.text = "반가워요"
        labelA.textColor = .black
        labelA.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 24)
        view.addSubview(labelA)
        labelA.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(136)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(24)
        }
        
        labelB.text = "000님!"
        labelB.textColor = .black
        labelB.font = UIFont.boldSystemFont(ofSize: 38)
        view.addSubview(labelB)
        labelB.snp.makeConstraints { make in
            make.leading.equalTo(labelA.snp.trailing).offset(8)
            make.bottom.equalTo(labelA.snp.bottom)
            
        }
        
        labelC.text = "내                    을 확인해볼까요?"
        labelC.textColor = .black
        labelC.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 24)
        view.addSubview(labelC)
        labelC.snp.makeConstraints { make in
            make.top.equalTo(labelA.snp.bottom).offset(8)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(24)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(50)
        }
        
        labelD.text = "에티켓 레벨"
        labelD.textColor = .black
        labelD.font = UIFont.boldSystemFont(ofSize: 27)
        view.addSubview(labelD)
        labelD.snp.makeConstraints { make in
            make.bottom.equalTo(labelC.snp.bottom)
            make.leading.equalTo(labelC.snp.leading).offset(24)
        }
        
        view.addSubview(imageView)
        imageView.image = UIImage(named: "QuizIntroImage")
        imageView.frame = CGRect(x: 0, y: 0, width: 276, height: 276)
        
        imageView.snp.makeConstraints { make in
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(171)
        }
        
        skipButton.setTitle("건너뛰기", for: .normal)
        skipButton.setTitleColor(UIColor(red: 0.63, green: 0.63, blue: 0.63, alpha: 1), for: .normal)
        skipButton.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1)
        skipButton.layer.cornerRadius = 25
        view.addSubview(skipButton)
        skipButton.snp.makeConstraints { make in
            make.width.equalTo(138)
            make.height.equalTo(51)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(655)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(32)
        }
        
        
        startButton.setTitle("Get Start!!", for: .normal)
        startButton.setTitleColor(.white, for: .normal)
        startButton.backgroundColor = UIColor.BeforeInRed
        startButton.layer.cornerRadius = 25
        view.addSubview(startButton)
        startButton.snp.makeConstraints { make in
            make.width.equalTo(skipButton.snp.width)
            make.height.equalTo(skipButton.snp.height)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(655)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(223)
        }
    }
    @objc func startButtonTapped(_ button: UIButton) {
        let rootVC = QuizViewController()
        
        rootVC.modalPresentationStyle = .fullScreen
        self.present(rootVC, animated: true)
    }
    @objc func skipButtonTapped(_ button: UIButton) {
        let skipVC = MainViewController()
        skipVC.modalPresentationStyle = .fullScreen
        self.present(skipVC, animated: true)
    }
}

