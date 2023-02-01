//
//  ProfileView.swift
//  ChatApp
//
//  Created by aykut ipek on 31.01.2023.
//

import UIKit
import FirebaseAuth
import SDWebImage

protocol ProfileViewProtocol : AnyObject{
    func signOutProfile()
}

class ProfileView: UIView{
    // MARK: - Properties
    var user: User?{
        didSet{ configure()}
    }
    weak var delegate: ProfileViewProtocol?
    let gradient = CAGradientLayer()
    private let profileImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.backgroundColor = .lightGray
        imageView.layer.borderWidth = 1.0
        return imageView
    }()
    private lazy var usernNameLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.attributedText = attributeTitle(headerTitle: "Username", title: "Aykut")
        return label
    }()
    private let nameLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    private lazy var signOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("SignOut", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor.systemRed
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title3)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.addTarget(self, action: #selector(handleSignOutButton), for: .touchUpInside)
        return button
    }()
    private lazy var stackView = UIStackView()
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        gradient.frame = bounds
    }
}

// MARK: - Selector
extension ProfileView{
    @objc private func handleSignOutButton(_ sender: UIButton){
        delegate?.signOutProfile()
    }
}

// MARK: - Helpers
extension ProfileView{
    private func setupUI(){
        style()
        layout()
    }
    private func style(){
        clipsToBounds = true
        gradient.locations = [0,1]
        gradient.colors = [UIColor.systemBlue.cgColor , UIColor.systemPink.cgColor]
        gradient.zPosition = -1
        layer.addSublayer(gradient)
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.layer.cornerRadius = 120 / 2
        
        stackView = UIStackView(arrangedSubviews: [nameLabel,usernNameLabel,signOutButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 5
    }
    private func layout(){
        addSubview(profileImageView)
        addSubview(stackView)
        NSLayoutConstraint.activate([
            //Profile Image Layout
            profileImageView.topAnchor.constraint(equalTo: topAnchor,constant: 18),
            profileImageView.widthAnchor.constraint(equalToConstant: 120),
            profileImageView.heightAnchor.constraint(equalToConstant: 120),
            profileImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            //Stack View Layout
            stackView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 12)
            
            
        ])
    }
    
    private func attributeTitle(headerTitle: String, title: String)-> NSMutableAttributedString{
        let attributed = NSMutableAttributedString(string: "\(headerTitle): ", attributes: [.foregroundColor: UIColor.white.withAlphaComponent(0.7), .font: UIFont.systemFont(ofSize: 16, weight: .bold)])
        attributed.append(NSAttributedString(string: title,attributes: [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 20, weight: .heavy)]))
        return attributed
    }
    private func configure(){
        guard let user = self.user else { return }
        self.usernNameLabel.attributedText = attributeTitle(headerTitle: "Username", title: "\(user.username)")
        self.nameLabel.attributedText = attributeTitle(headerTitle: "Name", title: "\(user.name)")
        self.profileImageView.sd_setImage(with: URL(string: user.profileImageURL))
    }
}

