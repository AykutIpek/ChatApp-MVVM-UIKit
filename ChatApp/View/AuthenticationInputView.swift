//
//  AuthenticationInputView.swift
//  ChatApp
//
//  Created by aykut ipek on 25.01.2023.
//

import UIKit

class AuthenticationInputView : UIView {
    init(image: UIImage , textfield: UITextField ) {
        super.init(frame: .zero)
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.tintColor = .white
        imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        textfield.translatesAutoresizingMaskIntoConstraints = false
        addSubview(textfield)
        let divider = UIView()
        divider.backgroundColor = .white
        divider.translatesAutoresizingMaskIntoConstraints = false
        addSubview(divider)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor , constant: 8),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 24),
            imageView.heightAnchor.constraint(equalToConstant: 24),
            
            textfield.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            textfield.leadingAnchor.constraint(equalTo: imageView.trailingAnchor , constant: 8),
            textfield.trailingAnchor.constraint(equalTo: trailingAnchor , constant: -8),
            
            divider.heightAnchor.constraint(equalToConstant: 0.70),
            divider.leadingAnchor.constraint(equalTo: leadingAnchor),
            divider.bottomAnchor.constraint(equalTo: bottomAnchor),
            divider.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

