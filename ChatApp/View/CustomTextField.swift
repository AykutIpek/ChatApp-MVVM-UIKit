//
//  CustomTextField.swift
//  ChatApp
//
//  Created by aykut ipek on 25.01.2023.
//

import UIKit

class CustomTextField : UITextField {
    init(placeHolder: String) {
        super.init(frame: .zero)
        attributedPlaceholder = NSMutableAttributedString(string: placeHolder , attributes: [.foregroundColor: UIColor.white])
        borderStyle = .none
        textColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
