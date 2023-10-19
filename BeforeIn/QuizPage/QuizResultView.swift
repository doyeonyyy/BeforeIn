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
        startButton.setTitle("비포인 시작하기", for: .normal)
        startButton.setTitleColor(.white, for: .normal)
        startButton.backgroundColor = UIColor.BeforeInRed
        startButton.layer.cornerRadius = 25
        startButton.snp.makeConstraints { make in
            make.width.equalTo(244)
            make.height.equalTo(51)
            make.bottom.equalTo(safeAreaLayoutGuide).inset(125)
            make.leading.equalTo(safeAreaLayoutGuide).offset(75)
        }
        levelImage.image = UIImage(named: "level1")
        levelImage.frame = CGRect(x: 0, y: 0, width: 131.25, height: 137)
        
        levelImage.snp.makeConstraints { make in
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.bottom.equalTo(safeAreaLayoutGuide).inset(240)
        }
        labelD.text = "Lv.1 검은머리 짐승"
        labelD.textColor = .black
        labelD.font = UIFont(name: "Inter-Regular", size: 14)
        labelD.snp.makeConstraints { make in
            make.top.equalTo(labelC.snp.bottom).offset(110)
            make.centerX.equalTo(safeAreaLayoutGuide)
        }
    }
    
    private func updateView() {
        labelB.text = "\(quizResultViewModel?.name ?? "ㅇㅇㅇ")님은 현재"
        labelD.text = quizResultViewModel?.level
        print("view 업데이트")
    }

}
