//
//  MainViewModel.swift
//  BeforeIn
//
//  Created by t2023-m079 on 10/17/23.
//

import Foundation

class MainViewModel {
    
    var user: User{
        didSet{
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
    var level: String {
        switch user.level{
        case 1: return "검은머리 짐승"
        case 2: return "훈련받은 짐승"
        case 3: return "이족보행 단계"
        case 4: return "인간"
        case 5: return "지성인"
        default: return "레벨 정보 없음"
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
        let content = (etiquette?.place ?? "로딩실패") + "에서는 " + (etiquette?.content[random]?[randomNumber].mainContent ?? "로딩실패")
        return content
    }
    var updateView: (() -> Void)?
    
    
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
