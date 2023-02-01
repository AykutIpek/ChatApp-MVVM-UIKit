//
//  LoginViewController.swift
//  ChatApp
//
//  Created by aykut ipek on 25.01.2023.
//

import UIKit
import JGProgressHUD

class LoginViewController : UIViewController {
    // MARK: Properties
    private var viewModel = LoginViewModel()
    private let logoImageView : UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "message")
        imageView.tintColor = .white
        return imageView
    }()
    private lazy var emailContainerView : AuthenticationInputView = {
        let containerView = AuthenticationInputView(image: UIImage(systemName: "envelope")!, textfield: emailTextField)
        return containerView
    }()
    private let emailTextField = CustomTextField(placeHolder: "Email")
    private lazy var passwordContainerView : AuthenticationInputView = {
        let containerView = AuthenticationInputView(image: UIImage(systemName: "lock")!, textfield: passwordTextField)
        return containerView
    }()
    private let passwordTextField : CustomTextField = {
        let textField = CustomTextField(placeHolder: "Password")
        textField.isSecureTextEntry = true
        return textField
    }()
    private var stackView = UIStackView()
    private lazy var loginButton : UIButton =  {
        let button = UIButton(type: .system)
        button.setTitle("Log in", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        button.isEnabled = false
        button.layer.cornerRadius = 7
        button.addTarget(self, action: #selector(handleLoginButton), for: .touchUpInside)
        return button
    }()
    private lazy var switchToRegistrationPage : UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Click to become a mamber" , attributes: [.foregroundColor: UIColor.white , .font: UIFont.systemFont(ofSize: 14)])
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleGoToRegisterView), for: .touchUpInside)
        return button
    }()

    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}
// MARK: Selector
extension LoginViewController {
    @objc private func handleLoginButton(_ sender: UIButton){
        guard let emailText = emailTextField.text else {return}
        guard let passwordText = passwordTextField.text else {return}
        showProgressHud(showProgress: true)
        AuthenticationService.login(withEmail: emailText, password: passwordText) { result, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                self.showProgressHud(showProgress: false)
                return
            }
            self.showProgressHud(showProgress: false)
            self.dismiss(animated: true)
        }
    }
    @objc private func handleTextChange(_ sender: UITextField){
        if sender == emailTextField{
            viewModel.emailTextField = sender.text
        }else{
            viewModel.passwordTextField = sender.text
        }
        loginButtonStatus()
    }
    @objc private func handleGoToRegisterView(_ sender: UIButton){
        let controller = RegisterViewController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
// MARK: Helpers
extension LoginViewController {
    private func loginButtonStatus(){
        if viewModel.status{
            loginButton.isEnabled = true
            loginButton.backgroundColor = .systemBlue
        }else{
            loginButton.isEnabled = false
            loginButton.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        }
    }
    
    private func setupUI(){
        style()
        layout()
        configureGradientLayer()
    }

    private func style(){
        self.navigationController?.navigationBar.isHidden = true
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        emailContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        //StackView style
        stackView = UIStackView(arrangedSubviews: [emailContainerView , passwordContainerView , loginButton])
        stackView.axis = .vertical
        stackView.spacing = 14
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        //emailTextField and passwordTextField
        emailTextField.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        
        //switchToRegistrationPage style
        switchToRegistrationPage.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    private func layout(){
        view.addSubview(logoImageView)
        view.addSubview(stackView)
        view.addSubview(switchToRegistrationPage)
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor , constant: 15),
            logoImageView.heightAnchor.constraint(equalToConstant: 150),
            logoImageView.widthAnchor.constraint(equalToConstant: 150),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            stackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor , constant: 32),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor , constant: 32),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor , constant: -32),
            emailContainerView.heightAnchor.constraint(equalToConstant: 50),
            
            switchToRegistrationPage.topAnchor.constraint(equalTo: stackView.bottomAnchor , constant: 8),
            switchToRegistrationPage.leadingAnchor.constraint(equalTo: view.leadingAnchor , constant: 32),
            view.trailingAnchor.constraint(equalTo: switchToRegistrationPage.trailingAnchor , constant: 32)
            
        ])
        
    }
}
