//
//  Quiz.swift
//  BeforeIn
//
//  Created by t2023-m079 on 10/16/23.
//

import Foundation

struct Quiz {
    let question: String
    let answer: String
}

struct UserAnswer {
    var isCorrect: Bool
    var selectedOption: String // "O" 또는 "X"를 저장
}
