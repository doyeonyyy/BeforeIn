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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let labelA = UILabel()
        labelA.text = "반가워요"
        labelA.textColor = .black
        labelA.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 24)
        view.addSubview(labelA)
        labelA.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(136)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(24)
        }

        let labelB = UILabel()
        labelB.text = "000님!"
        labelB.textColor = .black
        labelB.font = UIFont.boldSystemFont(ofSize: 38)
        view.addSubview(labelB)
        labelB.snp.makeConstraints { make in
            make.leading.equalTo(labelA.snp.trailing).offset(8)
            make.bottom.equalTo(labelA.snp.bottom)
            
        }
        
        let labelC = UILabel()
        labelC.text = "내                    을 확인해볼까요?"
        labelC.textColor = .black
        labelC.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 24)
        view.addSubview(labelC)
        labelC.snp.makeConstraints { make in
            make.top.equalTo(labelA.snp.bottom).offset(8)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(24)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(50)
        }
        
        let labelD = UILabel()
        labelD.text = "에티켓 레벨"
        labelD.textColor = .black
        labelD.font = UIFont.boldSystemFont(ofSize: 27)
        view.addSubview(labelD)
        labelD.snp.makeConstraints { make in
            make.bottom.equalTo(labelC.snp.bottom)
            make.leading.equalTo(labelC.snp.leading).offset(24)
        }
        
        let imageView = UIImageView()
        view.addSubview(imageView)
        imageView.image = UIImage(named: "QuizIntroImage")
        imageView.frame = CGRect(x: 0, y: 0, width: 276, height: 276)

        imageView.snp.makeConstraints { make in
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(171)
        }
         
        let buttonA = UIButton()
        buttonA.setTitle("건너뛰기", for: .normal)
        buttonA.setTitleColor(UIColor(red: 0.63, green: 0.63, blue: 0.63, alpha: 1), for: .normal)
        buttonA.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1)
        buttonA.layer.cornerRadius = 25
        view.addSubview(buttonA)
        buttonA.snp.makeConstraints { make in
            make.width.equalTo(138)
            make.height.equalTo(51)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(655)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(32)
        }
        
        let buttonB = UIButton()
        buttonB.setTitle("Get Start!!", for: .normal)
        buttonB.setTitleColor(.white, for: .normal)
        buttonB.backgroundColor = UIColor.BeforeInRed
        buttonB.layer.cornerRadius = 25
        view.addSubview(buttonB)
        buttonB.snp.makeConstraints { make in
            make.width.equalTo(buttonA.snp.width)
            make.height.equalTo(buttonA.snp.height)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(655)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(223)
        }
    }
}
