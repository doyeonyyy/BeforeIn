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
    let email: String
    let name: String
    let nickname: String
    let profileImage: UIImage
    let level: Int
    let phone: String
}
