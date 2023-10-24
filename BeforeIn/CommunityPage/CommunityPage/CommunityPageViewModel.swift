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
    
    var postingTime: String{
        var timeText = ""
        let timeInterval = Date().timeIntervalSince(post.postingTime)
        let seconds = Int(timeInterval)
        let minutes = Int(timeInterval / 60)
        let hours = Int(timeInterval / 3600)
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: post.postingTime, to: Date())
        let days = components.day ?? 0
        if days > 7 {
            timeText = "\(post.postingTime.toString("yyyy년 M월 d일"))"
        }
        else {
            if hours >= 24 {
                timeText = "\(days)일 전"
            }
            else if hours < 1 {
                if minutes >= 1 {
                    timeText = "\(minutes)분 전"
                }
                else {
                    timeText = "\(seconds)초 전"
                }
            }
            else {
                timeText = "\(hours)시간 전"
            }
        }
        return timeText
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

