//
//  QuizIntroView.swift
//  BeforeIn
//
//  Created by t2023-m0047 on 2023/10/19.
//

import UIKit

class QuizIntroView: UIView {
    
    let labelA = UILabel()
    private var labelB = UILabel()
    let labelC = UILabel()
    let labelD = UILabel()
    let imageView = UIImageView()
    let skipButton = UIButton()
    let startButton = UIButton()
    
    var quizIntroViewModel: QuizIntroViewModel? {
        didSet {
            quizIntroViewModel?.updateView = { [weak self] in
                self?.updateView()
            }
            updateView()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        setupLayout()
    }
    
    func setupUI() {
        addSubview(labelA)
        addSubview(labelB)
        addSubview(labelC)
        addSubview(labelD)
        addSubview(imageView)
        addSubview(skipButton)
        addSubview(startButton)
    }
    
    func setupLayout() {
        labelA.text = "반가워요"
        labelA.textColor = .black
        labelA.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 24)
        labelA.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(136)
            make.leading.equalTo(safeAreaLayoutGuide).offset(24)
        }
        
        labelB.textColor = .black
        labelB.font = UIFont.boldSystemFont(ofSize: 38)
        labelB.snp.makeConstraints { make in
            make.leading.equalTo(labelA.snp.trailing).offset(8)
            make.bottom.equalTo(labelA.snp.bottom)
        }
        labelC.text = "내                    을 확인해볼까요?"
        labelC.textColor = .black
        labelC.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 24)
        labelC.snp.makeConstraints { make in
            make.top.equalTo(labelA.snp.bottom).offset(8)
            make.leading.equalTo(safeAreaLayoutGuide).offset(24)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(50)
        }
        labelD.text = "에티켓 레벨"
        labelD.textColor = .black
        labelD.font = UIFont.boldSystemFont(ofSize: 27)
        labelD.snp.makeConstraints { make in
            make.bottom.equalTo(labelC.snp.bottom)
            make.leading.equalTo(labelC.snp.leading).offset(24)
        }
        imageView.image = UIImage(named: "QuizIntroImage")
        imageView.frame = CGRect(x: 0, y: 0, width: 276, height: 276)
        imageView.snp.makeConstraints { make in
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.bottom.equalTo(safeAreaLayoutGuide).inset(171)
        }
        skipButton.setTitle("건너뛰기", for: .normal)
        skipButton.setTitleColor(UIColor(red: 0.63, green: 0.63, blue: 0.63, alpha: 1), for: .normal)
        skipButton.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1)
        skipButton.layer.cornerRadius = 25
        skipButton.snp.makeConstraints { make in
            make.width.equalTo(138)
            make.height.equalTo(51)
            make.top.equalTo(safeAreaLayoutGuide).offset(655)
            make.leading.equalTo(safeAreaLayoutGuide).offset(32)
        }
        startButton.setTitle("Get Start!!", for: .normal)
        startButton.setTitleColor(.white, for: .normal)
        startButton.backgroundColor = UIColor.BeforeInRed
        startButton.layer.cornerRadius = 25
        startButton.snp.makeConstraints { make in
            make.width.equalTo(skipButton.snp.width)
            make.height.equalTo(skipButton.snp.height)
            make.top.equalTo(safeAreaLayoutGuide).offset(655)
            make.leading.equalTo(safeAreaLayoutGuide).offset(223)
        }
    }
    private func updateView() {
        labelB.text = "\(quizIntroViewModel?.name ?? "ㅇㅇㅇ")님!"
        print("View 업데이트")
    }
}

