//
//  User.swift
//  ChatApp
//
//  Created by aykut ipek on 30.01.2023.
//

import Foundation

struct User {
    let uid              : String
    let name             : String
    let username          : String
    let email            : String
    let profileImageURL    : String
    init(data: [String: Any]) {
        self.uid = data["uid"] as? String ?? ""
        self.name = data["name"] as? String ?? ""
        self.username = data["username"] as? String ?? ""
        self.email = data["email"] as? String ?? ""
        self.profileImageURL = data["profileImageURL"] as? String ?? ""
    }
}

struct LastUser {
    let user : User
    let message: Message
}
