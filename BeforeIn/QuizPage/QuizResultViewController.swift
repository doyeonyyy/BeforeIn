//
//  QuizResultViewController.swift
//  BeforeIn
//
//  Created by t2023-m0047 on 2023/10/13.
//
import Foundation
import UIKit
import SnapKit

class QuizResultViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let labelA = UILabel()
        labelA.text = "검사결과"
        labelA.textColor = .black
        labelA.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 20)
        view.addSubview(labelA)
        labelA.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(169)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(76)
        }
        
        let labelB = UILabel()
        labelB.text = "000님은"
        labelB.textColor = .black
        labelB.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 32)
        view.addSubview(labelB)
        labelB.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(158)
            make.leading.equalTo(labelA.snp.trailing).offset(4)
        }
        let labelC = UILabel()
        labelC.text = "Lv.1 검은머리짐승입니다"
        labelC.textColor = .black
        labelC.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 28)
        view.addSubview(labelC)
        labelC.snp.makeConstraints { make in
            make.top.equalTo(labelA.snp.bottom).offset(14)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(76)
        }
        
        let startButton = UIButton()
        startButton.setTitle("비포인 시작하기", for: .normal)
        startButton.setTitleColor(.white, for: .normal)
        startButton.backgroundColor = UIColor.BeforeInRed
        startButton.layer.cornerRadius = 25
        view.addSubview(startButton)
        startButton.snp.makeConstraints { make in
            make.width.equalTo(244)
            make.height.equalTo(51)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(125)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(75)
        }
        
        let levelImage = UIImageView()
        view.addSubview(levelImage)
        levelImage.image = UIImage(named: "level1")
        levelImage.frame = CGRect(x: 0, y: 0, width: 131.25, height: 137)
        
        levelImage.snp.makeConstraints { make in
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(240)
        }
    }
}
