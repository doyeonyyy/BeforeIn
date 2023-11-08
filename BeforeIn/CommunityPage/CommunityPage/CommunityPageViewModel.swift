//
//  CommunityPageViewModel.swift
//  BeforeIn
//
//  Created by t2023-m079 on 10/23/23.
//

import Foundation

class CommunityPageViewModel{
    var post: Post{
        didSet{
            self.updateView?()
        }
    }
    
    var title: String {
        return post.title
    }
    
    var content: String {
        return post.content
    }
    
    var category: String{
        return post.category
    }
    
    var nickname: String{
        return post.writerNickName
    }
    
    var writerEmail: String {
        return post.writer
    }
    
    var postingTime: String{
        let date = post.postingTime
        return date.getTimeText()
    }
    
    var likes: String{
        return String(post.likes) 
    }
    
    var updateView: (() -> Void)?
    
    
    init(post: Post) {
        self.post = post
    }
    
    func updatePost(_ post: Post) {
        print("view모델 post 업데이트")
        self.post = post
    }
    
}

