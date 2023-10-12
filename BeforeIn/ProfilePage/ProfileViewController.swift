//
//  ProfileViewController.swift
//  BeforeIn
//
//  Created by t2023-m079 on 10/11/23.
//

import UIKit

class ProfileViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Create a UILabel for nickname
        let nickname = UILabel()
        nickname.text = "000님"
        nickname.textColor = UIColor(red: 0.192, green: 0.192, blue: 0.192, alpha: 1)
        nickname.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        nickname.translatesAutoresizingMaskIntoConstraints = false
        nickname.textAlignment = .center // Center text alignment

        self.view.addSubview(nickname)

        NSLayoutConstraint.activate([
            nickname.heightAnchor.constraint(equalToConstant: 29),
            nickname.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 60),
            nickname.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24)
        ])

        // Create a UILabel for '의 프로필 입니다'
        let mentLabel = UILabel()
        mentLabel.text = "의 프로필 입니다"
        mentLabel.textColor = UIColor(red: 0.192, green: 0.192, blue: 0.192, alpha: 1)
        mentLabel.font = UIFont.systemFont(ofSize: 18)
        mentLabel.translatesAutoresizingMaskIntoConstraints = false
        mentLabel.textAlignment = .center // Center text alignment

        self.view.addSubview(mentLabel)

        NSLayoutConstraint.activate([
            mentLabel.heightAnchor.constraint(equalToConstant: 29),
            mentLabel.topAnchor.constraint(equalTo: nickname.topAnchor),
            mentLabel.leadingAnchor.constraint(equalTo: nickname.trailingAnchor, constant: 2)
        ])
    }
}
