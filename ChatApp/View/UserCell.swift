//
//  UserCell.swift
//  ChatApp
//
//  Created by aykut ipek on 30.01.2023.
//

import UIKit
import SDWebImage

class UserCell: UITableViewCell{
    //MARK: - Properties
    var user: User?{
        didSet{
            configureUserCell()
        }
    }
    private var profileImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    private let title : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.text = "Title"
        return label
    }()
    private let subTitle : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .lightGray
        label.text = "SubTitle"
        return label
    }()
    private var stackView = UIStackView()
    //MARK: - LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Helpers
extension UserCell {
    private func setupUI(){
        style()
        layout()
    }
    private func style(){
        //ProfileImageView style
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.layer.cornerRadius = 55 / 2
        
        //StackView
        stackView = UIStackView(arrangedSubviews: [title,subTitle])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    private func layout(){
        addSubview(profileImageView)
        addSubview(stackView)
        NSLayoutConstraint.activate([
            //ProfileImageView layout
            profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            profileImageView.heightAnchor.constraint(equalToConstant: 55),
            profileImageView.widthAnchor.constraint(equalToConstant: 55),
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            
            //StackView
            stackView.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor , constant: 10),
            trailingAnchor.constraint(equalTo: stackView.trailingAnchor , constant: 4),
            stackView.topAnchor.constraint(equalTo: topAnchor,constant: 4),
            bottomAnchor.constraint(equalTo: stackView.bottomAnchor , constant: 10),
            
        ])
    }
    private func configureUserCell(){
        guard let user = user else {return}
        self.title.text = user.name
        self.profileImageView.sd_setImage(with: URL(string: user.profileImageURL))
        self.subTitle.text = user.username
    }
}
