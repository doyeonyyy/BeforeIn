//
//  QuizIntroViewModel.swift
//  BeforeIn
//
//  Created by t2023-m0047 on 2023/10/18.
//

import Foundation

class QuizIntroViewModel {
    var user: User {
        didSet{
            self.updateView?()
        }
    }
    var nickname: String {
        return user.name
    }
    
    var updateView: (() -> Void)?
    
    init(user: User) {
        self.user = user
    }
    
    func updateUser(_ user: User) {
        self.user = user
    }
}
