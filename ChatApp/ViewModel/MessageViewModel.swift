//
//  MessageViewModel.swift
//  ChatApp
//
//  Created by aykut ipek on 31.01.2023.
//

import Foundation

struct MessageViewModel{
    private let lastUser: LastUser
    init(lastUser: LastUser) {
        self.lastUser = lastUser
    }
    
    var profileImage : URL?{
        return URL(string: lastUser.user.profileImageURL)
    }
    
    var timestampString: String{
        let date = lastUser.message.timestamp.dateValue()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter.string(from: date)
    }
}
