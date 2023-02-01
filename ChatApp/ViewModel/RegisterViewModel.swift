//
//  RegisterViewModel.swift
//  ChatApp
//
//  Created by aykut ipek on 25.01.2023.
//

import UIKit

class RegisterViewModel {
    var email : String?
    var username : String?
    var name : String?
    var password : String?
    
    var status : Bool {
        return email?.isEmpty == false && username?.isEmpty == false && name?.isEmpty == false && password?.isEmpty == false
    }
}
