//
//  ChatViewController.swift
//  ChatApp
//
//  Created by aykut ipek on 30.01.2023.
//

import UIKit

protocol ChatInputViewProtocol: AnyObject {
    func sendMessage(_ chatInputView: ChatInputView , message: String)
}

class ChatInputView: UIView {
    // MARK: - Properties
    weak var delegate: ChatInputViewProtocol?
    private let textInputView : UITextView = {
        let textView = UITextView()
        textView.font = UIFont.preferredFont(forTextStyle: .title3)
        return textView
    }()
    private lazy var sendButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Send", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title3)
        button.addTarget(self, action: #selector(handleSendButton), for: .touchUpInside)
        return button
    }()
    private let placeHolderLabel : UILabel = {
        let label = UILabel()
        label.text = "Message"
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        return label
    }()
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Helpers
extension ChatInputView {
    private func setupUI(){
        style()
        layout()
    }
    private func style(){
        autoresizingMask = .flexibleHeight
        configureGradientLayer()
        clipsToBounds = true
        layer.cornerRadius = 15
        layer.maskedCorners = [.layerMinXMinYCorner , .layerMaxXMinYCorner]
        textInputView.translatesAutoresizingMaskIntoConstraints = false
        textInputView.layer.cornerRadius = 10
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextInputView), name: UITextView.textDidChangeNotification, object: nil)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        placeHolderLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    private func layout(){
        addSubview(textInputView)
        addSubview(sendButton)
        addSubview(placeHolderLabel)
        NSLayoutConstraint.activate([
            //Text Input View Layout
            textInputView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            textInputView.leadingAnchor.constraint(equalTo: leadingAnchor , constant: 16),
            textInputView.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor , constant: -4),
            bottomAnchor.constraint(equalTo: textInputView.bottomAnchor , constant: 16),
            //Send Button Layout
            sendButton.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            trailingAnchor.constraint(equalTo: sendButton.trailingAnchor , constant: 8),
            sendButton.heightAnchor.constraint(equalToConstant: 55),
            sendButton.widthAnchor.constraint(equalToConstant: 55),
            //Placeholder Label Layout
            placeHolderLabel.topAnchor.constraint(equalTo: textInputView.topAnchor),
            placeHolderLabel.leadingAnchor.constraint(equalTo: textInputView.leadingAnchor , constant: 8),
            placeHolderLabel.trailingAnchor.constraint(equalTo: textInputView.trailingAnchor),
            placeHolderLabel.bottomAnchor.constraint(equalTo: textInputView.bottomAnchor , constant: -8)
        ])
    }
    func clear(){
        textInputView.text = nil
        placeHolderLabel.isHidden = false
    }
}


//MARK: -Helpers
extension ChatInputView {
    @objc private func handleTextInputView(){
        placeHolderLabel.isHidden = !textInputView.text.isEmpty
    }
    @objc private func handleSendButton(_ sender: UIButton){
        guard let message = textInputView.text else {return}
        self.delegate?.sendMessage(self, message: message)
    }
}
