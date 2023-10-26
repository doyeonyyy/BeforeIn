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
    let labelD = UILabel()
    let stackViewForLabelCD = UIStackView()
    let startButton = UIButton()
    let levelImage = UIImageView()


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
        addSubview(stackViewForLabelCD)
        stackViewForLabelCD.addArrangedSubview(labelC)
        stackViewForLabelCD.addArrangedSubview(labelD)
        addSubview(startButton)
        addSubview(levelImage)
    }
    
    func setupLayout() {
        labelA.text = "검사결과"
        labelA.textColor = .black
        labelA.font = UIFont.systemFont(ofSize: 24)
        labelA.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(106)
            make.leading.equalTo(safeAreaLayoutGuide).offset(76)
        }
        labelB.text = "000님은"
        labelB.textColor = .black
        labelB.font = UIFont(name: "SUITE-SemiBold", size: 24)
        labelB.snp.makeConstraints { make in
            make.bottom.equalTo(labelA.snp.bottom)
            make.leading.equalTo(labelA.snp.trailing).offset(8)
        }
        labelC.text = "Lv.1 검은머리 짐승입니다"
        labelC.textColor = .beforeInRed
        labelC.font = UIFont.systemFont(ofSize: 24, weight: .bold)

        labelD.text = "입니다"
        labelD.textColor = .black
        labelD.font = UIFont.systemFont(ofSize: 24)

        stackViewForLabelCD.axis = .horizontal
        stackViewForLabelCD.alignment = .center
        stackViewForLabelCD.spacing = 4
        stackViewForLabelCD.snp.makeConstraints { make in
            make.top.equalTo(labelA.snp.bottom).offset(14)
            make.centerX.equalToSuperview()
        }
        levelImage.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(safeAreaLayoutGuide)
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
            make.bottom.equalToSuperview().offset(-80)
            make.centerX.equalToSuperview()

        }
        
    }
    
    private func updateView() {
        labelB.text = "\(quizResultViewModel?.nickname ?? "ㅇㅇㅇ")님은"
        labelC.text = "Lv .\(quizResultViewModel?.level ?? 1) \(quizResultViewModel?.levelText ?? "검은머리 짐승")"
        levelImage.image = quizResultViewModel?.levelImage
        print("view 업데이트")
    }
}
