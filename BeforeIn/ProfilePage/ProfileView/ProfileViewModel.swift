//
//  ProfileViewModel.swift
//  BeforeIn
//
//  Created by t2023-m079 on 10/18/23.
//

import Foundation
import UIKit

class ProfileViewModel{
    
    let userManager = UserManager()
    
    var user: User{
        didSet{
            self.updateView?()
        }
    }
    
    //    var name: String {
    //        return "\(user.name)님"
    //    }
    
    var email: String{
        return user.email
    }
    
    var nameBox: String{
        return "\(user.name)님은 현재"
    }
    
    var nickname: String{
        return "\(user.nickname)님"
    }
    
    var imageURL: String {
        return user.profileImage
    }
    
    var level: Int{
        return user.level
    }
    
    var levelNumberText: String{
        switch user.level{
        case 1: return "Lv 1"
        case 2: return "Lv 2"
        case 3: return "Lv 3"
        case 4: return "Lv 4"
        case 5: return "Lv 5"
        default: return "레벨 정보 없음"
        }
    }
    
    var levelText: String {
        switch user.level{
        case 1: return "검은머리 짐승"
        case 2: return "훈련받은 짐승"
        case 3: return "이족보행 단계"
        case 4: return "인간"
        case 5: return "지성인"
        default: return "레벨 정보 없음"
        }
    }
    
    var updateView: (() -> Void)?
    
    
    init(user: User) {
        self.user = user
    }
    
    func updateUser(_ user: User) {
        print("profileView모델 user 업데이트")
        self.user = user
    }
    
}
