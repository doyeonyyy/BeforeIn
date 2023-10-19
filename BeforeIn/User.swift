//
//  User.swift
//  BeforeIn
//
//  Created by t2023-m079 on 10/16/23.
//

import Foundation
import UIKit

var currentUser = User(email: "", name: "", nickname: "", profileImage: UIImage(systemName: "person.fill")!, level: 5, phone: "")

struct User {
    var email: String
    var name: String
    var nickname: String
    var profileImage: UIImage
    var level: Int
    let phone: String
}
