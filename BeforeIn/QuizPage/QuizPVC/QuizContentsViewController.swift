//
//  QuizContentsViewController.swift
//  BeforeIn
//
//  Created by t2023-m0047 on 2023/10/14.
//
import Foundation
import UIKit
import SnapKit

class QuizContentsViewController: UIViewController {

    private var stackView: UIStackView!
    
    private var contentLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
    }
    
    init(contentLabel: String) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        contentLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 24);
        contentLabel.textAlignment = .center
        contentLabel.numberOfLines = 0
        
        self.stackView = UIStackView(arrangedSubviews: [contentLabel])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .center
    }
    
    private func setupLayout() {
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().inset(50)
        }
    }
}
