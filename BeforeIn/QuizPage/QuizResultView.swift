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
    let stackViewForLabelAB = UIStackView()
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
        addSubview(stackViewForLabelAB)
        stackViewForLabelAB.addArrangedSubview(labelA)
        stackViewForLabelAB.addArrangedSubview(labelB)
        addSubview(stackViewForLabelCD)
        stackViewForLabelCD.addArrangedSubview(labelC)
        stackViewForLabelCD.addArrangedSubview(labelD)
        addSubview(startButton)
        addSubview(levelImage)
    }
    
    func setupLayout() {
        labelA.text = "검사결과"
        labelA.font = UIFont.systemFont(ofSize: 22)

        labelB.text = "000님은"
        labelB.font = UIFont(name: "SUITE-SemiBold", size: 24)
    
        labelC.text = "Lv.1 검은머리 짐승"
        labelC.textColor = .BeforeInRed
        labelC.font = UIFont.systemFont(ofSize: 22, weight: .bold)

        labelD.text = "입니다"
        labelD.font = UIFont.systemFont(ofSize: 22)
        
        stackViewForLabelAB.axis = .horizontal
        stackViewForLabelAB.alignment = .center
        stackViewForLabelAB.spacing = 4
        stackViewForLabelAB.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(106)
            make.centerX.equalToSuperview()
        }

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
        startButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        startButton.layer.cornerRadius = 8
        startButton.snp.makeConstraints { make in
            make.left.right.equalTo(self.safeAreaLayoutGuide).inset(24)
            make.height.equalTo(50)
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
