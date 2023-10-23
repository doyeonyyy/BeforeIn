//
//  Post.swift
//  BeforeIn
//
//  Created by t2023-m079 on 10/23/23.
//

import Foundation

struct Post{
    let writer: String // email
    let writerNickName: String
    let postID: String
    let title: String
    let content: String
    let comments: [Comment]
    let likes: Int
    let category: String
    let postingTime: Date
}
