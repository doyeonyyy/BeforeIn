//
//  Comment.swift
//  BeforeIn
//
//  Created by t2023-m079 on 10/23/23.
//

import Foundation

struct Comment: Equatable {
    
    let writer: String
    let writerNickName: String
    var content: String
    let postingTime: Date
    var reportUserList: [String] // 신고한 사람들의 이메일 리스트
}
