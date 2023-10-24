//
//  QuizResultView.swift
//  BeforeIn
//
//  Created by t2023-m0047 on 2023/10/18.
//

import UIKit

class QuizResultView: UIView {
    let labelA = UILabel()
    let labelB = UILabel()
    let labelC = UILabel()
    let startButton = UIButton()
    let levelImage = UIImageView()
    let labelD = UILabel()

    var quizResultViewModel: QuizResultViewModel? {
        didSet {
            quizResultViewModel?.updateView = { [weak self] in
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
        backgroundColor = .systemBackground
        addSubview(labelA)
        addSubview(labelB)
        addSubview(labelC)
        addSubview(startButton)
        addSubview(levelImage)
        addSubview(labelD)
    }
    
    func setupLayout() {
        labelA.text = "검사결과"
        labelA.textColor = .black
        labelA.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 20)
        labelA.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(169)
            make.leading.equalTo(safeAreaLayoutGuide).offset(76)
        }
        labelB.text = "000님은"
        labelB.textColor = .black
        labelB.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 32)
        labelB.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(158)
            make.leading.equalTo(labelA.snp.trailing).offset(4)
        }
        labelC.text = "Lv.1 검은머리 짐승입니다"
        labelC.textColor = .black
        labelC.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 28)
        labelC.snp.makeConstraints { make in
            make.top.equalTo(labelA.snp.bottom).offset(14)
            make.leading.equalTo(safeAreaLayoutGuide).offset(76)
        }
        levelImage.snp.makeConstraints { make in
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.top.equalTo(labelC.snp.bottom)
            make.width.equalTo(200)
            make.height.equalTo(200)
        }
        levelImage.image = UIImage(named: "level1")
        
        startButton.setTitle("비포인 시작하기", for: .normal)
        startButton.setTitleColor(.white, for: .normal)
        startButton.backgroundColor = UIColor.BeforeInRed
        startButton.layer.cornerRadius = 25
        startButton.snp.makeConstraints { make in
            make.width.equalTo(244)
            make.height.equalTo(51)
//            make.bottom.equalTo(safeAreaLayoutGuide).inset(125)
            make.top.equalTo(levelImage.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
//            make.leading.equalTo(safeAreaLayoutGuide).offset(75)
        }
        
    }
    
    private func updateView() {
        labelB.text = "\(quizResultViewModel?.nickname ?? "ㅇㅇㅇ")님은 현재"
        labelC.text = "Lv .\(quizResultViewModel?.level ?? 1) \(quizResultViewModel?.levelText ?? "검은머리 짐승")입니다"
        levelImage.image = quizResultViewModel?.levelImage
        print("view 업데이트")
    }
}
