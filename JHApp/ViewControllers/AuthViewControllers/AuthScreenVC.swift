//
//  AuthScreen.swift
//  JHApp
//
//  Created by Егорио on 25.11.2024.
//

import UIKit
import SnapKit

class AuthScreenVC: UIViewController {
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let titleLabel = TitleLabel(text: "Войдите в свою учетную запись")
    private let subTitleLabel = SubTitleLabel(text: "Войдите в свой аккаунт, чтобы получить полный доступ ко всем возможностям нашего приложения")
    private let authRectangleView = ComponentsBackground(cornerRadius: 16, corners: [.allCorners])
    private let loginLabel = DefaultLabel(text: "Электронная почта", fontSize: 18, weight: .regular)
    private let loginTextField = TextField(placeholder: "Введите электронную почту", leftPadding: 20, cornerRadius: 12, roundedCorners: [.allCorners])
    private let passwordLabel = DefaultLabel(text: "Пароль", fontSize: 18, weight: .regular)
    private let passwordTextField = TextField(placeholder: "Введите пароль", leftPadding: 20, cornerRadius: 12, roundedCorners: [.allCorners])
    private let authButton = Button(setTitle: "Войти")
    private let registerButton = Button(setTitle: "Зарегистрироваться!")
    private let forgotPasswordButton = Button(setTitle: "Забыли пароль?")
    private let backButton = Button(setTitle: "Назад")
    private let socialMediaLabel = SubTitleLabel(text: "Или вы можете подключиться с помощью: (в процессе разработки...)")
    private let socialMediaRectangleView = ComponentsBackground(cornerRadius: 16, corners: [.allCorners])
    private let appleLogo = AuthImages(imageName: "appleLogo")
    private let vkLogo = AuthImages(imageName: "vkLogo")
    private let googleLogo = AuthImages(imageName: "googleLogo")
    private lazy var socialMediaStackView = SocialMediaStackView(appleLogo: appleLogo, vkLogo: vkLogo, googleLogo: googleLogo)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupScrollView()
        setupUI()
        setupConstraints()
        setupActions()
    }
    
    private func setupView() {
        view.backgroundColor = Styles.Colors.appBackgoundColor
        navigationController?.setNavigationBarHidden(true, animated: false)
        setupDismissKeyboardGesture()
    }
    
    private func setupDismissKeyboardGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    private func setupScrollView() {
        scrollView.delaysContentTouches = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(scrollView)
        }
    }
    
    private func setupUI() {
        [
            titleLabel,
            subTitleLabel,
            authRectangleView,
            loginLabel,
            loginTextField,
            passwordLabel,
            passwordTextField,
            authButton,
            socialMediaLabel,
            socialMediaRectangleView,
            socialMediaStackView,
            registerButton,
            forgotPasswordButton,
            backButton
        ].forEach { contentView.addSubview($0) }
    }
    
    private func setupActions() {
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        forgotPasswordButton.addTarget(self, action: #selector(goToForgotPassword), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(goToRegister), for: .touchUpInside)
        authButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        authButton.addTarget(self, action: #selector(dismissKeyboard), for: .touchDown)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(40)
            make.top.equalToSuperview().offset(20)
        }
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.leading.trailing.equalTo(titleLabel)
        }
        authRectangleView.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        loginLabel.snp.makeConstraints { make in
            make.top.equalTo(authRectangleView).offset(30)
            make.leading.trailing.equalTo(authRectangleView).inset(30)
        }
        loginTextField.snp.makeConstraints { make in
            make.top.equalTo(loginLabel.snp.bottom).offset(15)
            make.leading.trailing.equalTo(authRectangleView).inset(20)
            make.height.equalTo(50)
        }
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(loginTextField.snp.bottom).offset(30)
            make.leading.trailing.equalTo(authRectangleView).inset(30)
        }
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(15)
            make.leading.trailing.equalTo(authRectangleView).inset(20)
            make.height.equalTo(50)
        }
        authButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.leading.trailing.equalTo(authRectangleView).inset(20)
            make.height.equalTo(50)
            make.bottom.equalTo(authRectangleView.snp.bottom).inset(30)
        }
        socialMediaLabel.snp.makeConstraints { make in
            make.top.equalTo(authRectangleView.snp.bottom).offset(30)
            make.leading.trailing.equalTo(titleLabel)
        }
        socialMediaRectangleView.snp.makeConstraints { make in
            make.top.equalTo(socialMediaLabel.snp.bottom).offset(30)
            make.leading.trailing.equalTo(authRectangleView)
            make.height.equalTo(120)
        }
        socialMediaStackView.snp.makeConstraints { make in
            make.center.equalTo(socialMediaRectangleView)
        }
        registerButton.snp.makeConstraints { make in
            make.top.equalTo(socialMediaRectangleView.snp.bottom).offset(30)
            make.leading.trailing.equalTo(authRectangleView)
            make.height.equalTo(50)
        }
        forgotPasswordButton.snp.makeConstraints { make in
            make.top.equalTo(registerButton.snp.bottom).offset(20)
            make.leading.trailing.equalTo(authRectangleView)
            make.height.equalTo(50)
        }
        backButton.snp.makeConstraints { make in
            make.top.equalTo(forgotPasswordButton.snp.bottom).offset(20)
            make.leading.trailing.equalTo(authRectangleView)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().inset(50)
        }
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func loginButtonTapped() {
        let loginRequest = LoginUserRequest(email: loginTextField.text ?? "",
                                            password: passwordTextField.text ?? "")
        if !Validator.isValidEmail(for: loginRequest.email) {
            AlertManager.showInvalidEmailAlert(on: self)
            return
        }
        if !Validator.isPasswordValid(for: loginRequest.password) {
            AlertManager.showInvalidPasswordAlert(on: self)
            return
        }
        AuthService.shared.signIn(with: loginRequest) { error in
            if let error = error {
                AlertManager.showSignInErrorAlert(on: self)
                return
            }
            if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                sceneDelegate.checkAuthentication()
            }
        }
    }
    
    @objc private func goToRegister() {
        let registerScreenVC = RegistrationVC()
        navigationController?.pushViewController(registerScreenVC, animated: true)
    }
    
    @objc private func goToForgotPassword() {
        let forgotPasswordScreenVC = ForgotPasswordVС()
        navigationController?.pushViewController(forgotPasswordScreenVC, animated: true)
    }
    
    @objc private func backButtonTapped() {
        let welcomeScreenVC = WelcomeScreenVC()
        navigationController?.pushViewController(welcomeScreenVC, animated: true)
    }
}

