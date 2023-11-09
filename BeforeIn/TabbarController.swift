//
//  TabbarController.swift
//  BeforeIn
//
//  Created by t2023-m079 on 10/12/23.
//

import UIKit
import FirebaseAuth

class TapbarController: UITabBarController {
    
    private var handle: AuthStateDidChangeListenerHandle?
    let userManager = UserManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewControllerSetting()
        self.tabBarSetting()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.setCurrentUser()
//        print("탭바 viewWillAppear")
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
        appearance.shadowColor = .systemGray3
   
        let attributes = [NSAttributedString.Key.font: UIFont(name: "SUITE-Regular", size: 9)!]
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = attributes
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = attributes

        self.tabBar.standardAppearance = appearance
        self.tabBar.scrollEdgeAppearance = appearance
    }

    private func viewControllerSetting() {
        let vc1 = UINavigationController(rootViewController: MainViewController())
        let vc2 = UINavigationController(rootViewController: SearchViewController())
        let vc3 = UINavigationController(rootViewController: CommunityViewController())
        let vc4 = UINavigationController(rootViewController: ProfileViewController())
        vc1.tabBarItem = UITabBarItem(title: "홈", image: UIImage(named: "cave"), selectedImage: UIImage(named: "cave.fill"))
        vc2.tabBarItem = UITabBarItem(title: "검색", image: UIImage(named: "binoculars"), selectedImage: UIImage(named: "binoculars.fill"))
        vc3.tabBarItem = UITabBarItem(title: "에티켓숲", image: UIImage(named: "forest"), selectedImage: UIImage(named: "forest.fill"))
        vc4.tabBarItem = UITabBarItem(title: "내 정보", image: UIImage(named: "profile"), selectedImage: UIImage(named: "profile"))

        vc1.navigationBar.tintColor = .systemGray2
        vc2.navigationBar.tintColor = .systemGray2
        vc3.navigationBar.tintColor = .systemGray2
        vc4.navigationBar.tintColor = .systemGray2
        
        setViewControllers([vc1, vc2, vc3, vc4], animated: false)
//        setViewControllers([vc1, vc2, vc4], animated: false)

    }
    
    private func setCurrentUser(){
        handle = Auth.auth().addStateDidChangeListener { auth, user in
            if let user = user, let email = user.email {
                self.userManager.findUser(email: email) { findUser in
                    if let user = findUser {
                        currentUser = user
                    }
                }
            }
        }
    }
}
