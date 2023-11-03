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
    let labelE = UILabel()
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
        addSubview(labelE)
        addSubview(imageView)
        addSubview(skipButton)
        addSubview(startButton)
    }
    
    func setupLayout() {
        labelA.text = "반가워요"
//        labelA.textColor = .black
        labelA.font = UIFont.systemFont(ofSize: 20)
        labelA.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(106)
            make.leading.equalTo(safeAreaLayoutGuide).offset(24)
        }
        
//        labelB.textColor = .black
        labelB.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        labelB.snp.makeConstraints { make in
            make.leading.equalTo(labelA.snp.trailing).offset(8)
            make.bottom.equalTo(labelA.snp.bottom)
        }
        labelC.text = "내"
//        labelC.textColor = .black
        labelC.font = UIFont.systemFont(ofSize: 20)
        labelC.snp.makeConstraints { make in
            make.top.equalTo(labelA.snp.bottom).offset(8)
            make.leading.equalTo(safeAreaLayoutGuide).offset(24)
        }
        labelD.text = "에티켓 레벨"
//        labelD.textColor = .black
        labelD.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        labelD.snp.makeConstraints { make in
            make.top.equalTo(labelA.snp.bottom).offset(8)
            make.leading.equalTo(labelC.snp.trailing).offset(6)
        }
        labelE.text = "을 확인해볼까요?"
//        labelE.textColor = .black
        labelE.font = UIFont.systemFont(ofSize: 20)
        labelE.snp.makeConstraints { make in
            make.top.equalTo(labelA.snp.bottom).offset(8)
            make.leading.equalTo(labelD.snp.trailing)
        }
        imageView.image = UIImage(named: "QuizIntroImage")
        imageView.snp.makeConstraints { make in
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.centerY.equalToSuperview().offset(120)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(imageView.snp.width).multipliedBy(imageView.image!.size.height / imageView.image!.size.width)
        }
        skipButton.setTitle("건너뛰기", for: .normal)
        skipButton.setTitleColor(UIColor(red: 0.63, green: 0.63, blue: 0.63, alpha: 1), for: .normal)
        skipButton.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1)
        skipButton.layer.cornerRadius = 25
        skipButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        skipButton.snp.makeConstraints { make in
            make.width.equalTo(138)
            make.height.equalTo(51)
            make.bottom.equalToSuperview().offset(-80)
            make.leading.equalTo(safeAreaLayoutGuide).offset(32)
        }
        startButton.setTitle("퀴즈풀기", for: .normal)
        startButton.setTitleColor(.white, for: .normal)
        startButton.backgroundColor = UIColor.BeforeInRed
        startButton.layer.cornerRadius = 25
        startButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        startButton.snp.makeConstraints { make in
            make.width.equalTo(skipButton.snp.width)
            make.height.equalTo(skipButton.snp.height)
            make.bottom.equalToSuperview().offset(-80)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-32)
        }
    }
    private func updateView() {
        labelB.text = "\(quizIntroViewModel?.nickname ?? "ㅇㅇㅇ")님!"
    }
}
