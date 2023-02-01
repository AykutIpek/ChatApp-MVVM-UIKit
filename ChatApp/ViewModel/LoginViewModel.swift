//
//  LoginViewModel.swift
//  ChatApp
//
//  Created by aykut ipek on 25.01.2023.
//

import UIKit

struct LoginViewModel {
    var emailTextField : String?
    var passwordTextField : String?
    var status : Bool {
        return emailTextField?.isEmpty == false && passwordTextField?.isEmpty == false
    }
}
