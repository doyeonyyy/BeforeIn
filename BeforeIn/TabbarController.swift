//
//  TabbarController.swift
//  BeforeIn
//
//  Created by t2023-m079 on 10/12/23.
//

import UIKit

class TapbarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewControllerSetting()
        self.tabBarSetting()
    }

    private func tabBarSetting() {
        // 기존의 설정
        self.tabBar.backgroundColor = .systemBackground
        self.modalPresentationStyle = .fullScreen
        self.tabBar.unselectedItemTintColor = .systemGray
        self.tabBar.tintColor = .BeforeInRed

        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundEffect = nil
        appearance.shadowColor = nil

        self.tabBar.standardAppearance = appearance
        self.tabBar.scrollEdgeAppearance = appearance
    }

    private func viewControllerSetting() {
        let vc1 = UINavigationController(rootViewController: MainViewController())
        let vc2 = UINavigationController(rootViewController: SearchViewController())
        let vc3 = UINavigationController(rootViewController: RegisterViewController())
        vc1.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        vc2.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "books.vertical"), selectedImage: UIImage(systemName: "books.vertical.fill"))
        vc3.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))


        setViewControllers([vc1, vc2, vc3], animated: false)

    }
}
