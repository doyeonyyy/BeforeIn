//
//  MainViewModel.swift
//  BeforeIn
//
//  Created by t2023-m079 on 10/17/23.
//

import Foundation

class MainViewModel {
    
    let userManager = UserManager()
    
    var user: User {
         didSet {
             self.updateProfileImage?()
             self.updateView?()
         }
     }
    
    var etiquette: Etiquette?{
        didSet{
            self.updateView?()
        }
    }
    
    var name: String {
        return user.name
    }
    
    var nickname: String{
        return user.nickname
    }
    
    var profileImageURL: String {
        return user.profileImage
    }
    
    var level: String {
        switch user.level{
        case 1: return "검은머리 짐승"
        case 2: return "훈련받은 짐승"
        case 3: return "이족보행 단계"
        case 4: return "인간"
        case 5: return "지성인"
        default: return "검은머리 짐승"
        }
    }
    
    var levelNumberText: String{
        switch user.level{
        case 1: return "Lv 1"
        case 2: return "Lv 2"
        case 3: return "Lv 3"
        case 4: return "Lv 4"
        case 5: return "Lv 5"
        default: return "Lv 1"
        }
    }
    
    var etiquetteContent: String {
        var random = ""
        switch Int.random(in: 0...1){
        case 0: random = "good"
        case 1: random = "bad"
        default: random = "good"
        }
        let contentCount = etiquette?.content[random]?.count ?? 1
        let randomNumber = Int.random(in: 0..<contentCount)
        let content = (etiquette?.place ?? "결혼식장") + "에서는 " + (etiquette?.content[random]?[randomNumber].mainContent ?? "밝은 옷은 피해주세요")
        return content
    }
    
    var updateView: (() -> Void)?
    var updateProfileImage: (() -> Void)?
    
    
    init(user: User) {
        self.user = user
    }
    
    func updateUser(_ user: User) {
        print("view모델 user 업데이트")
        self.user = user
    }
    
    func updateEtiquette(_ etiquette: Etiquette){
        self.etiquette = etiquette
        print("view모델 etiquette 업데이트")
    }

}
