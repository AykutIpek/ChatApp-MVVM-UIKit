//
//  MessageCell.swift
//  ChatApp
//
//  Created by aykut ipek on 31.01.2023.
//

import UIKit
import SDWebImage

class MessageCell: UITableViewCell {
    // MARK: - Properties
    var lastUser: LastUser?{
        didSet{ configureMessageCell() }
    }
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    private let lastMessageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    private var stackView = UIStackView()
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .lightGray
        label.text = "5:5"
        return label
    }()
    // MARK: - Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK: - Helpers
extension MessageCell{
    private func setupUI(){
        style()
        layout()
    }
    private func style(){
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.layer.cornerRadius = 55 / 2
        
        stackView = UIStackView(arrangedSubviews: [usernameLabel, lastMessageLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 4
        
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        
    }
    private func layout(){
        addSubview(profileImageView)
        addSubview(stackView)
        addSubview(timeLabel)
        NSLayoutConstraint.activate([
            profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            profileImageView.heightAnchor.constraint(equalToConstant: 55),
            profileImageView.widthAnchor.constraint(equalToConstant: 55),
            
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor , constant: 8),
            trailingAnchor.constraint(equalTo: stackView.trailingAnchor , constant: 12),
            
            timeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            trailingAnchor.constraint(equalTo: timeLabel.trailingAnchor, constant: 8)
        ])
    }
    private func configureMessageCell(){
        guard let lastUser = self.lastUser else {return}
        let viewModel = MessageViewModel(lastUser: lastUser)
        self.usernameLabel.text = lastUser.user.username
        self.lastMessageLabel.text = lastUser.message.text
        self.profileImageView.sd_setImage(with: viewModel.profileImage)
        self.timeLabel.text = viewModel.timestampString
    }
}

// MARK: - Actions
