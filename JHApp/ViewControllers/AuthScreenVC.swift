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
    private let loginLabel = DefaultLabel(text: "Логин", fontSize: 18, weight: .regular)
    private let loginTextField = TextField(placeholder: "Введите электронную почту", leftPadding: 20, cornerRadius: 12, roundedCorners: [.allCorners])
    private let passwordLabel = DefaultLabel(text: "Пароль", fontSize: 18, weight: .regular)
    private let passwordTextField = TextField(placeholder: "Введите пароль", leftPadding: 20, cornerRadius: 12, roundedCorners: [.allCorners])
    private let authButton = Button(setTitle: "Войти")
    private let registerButton = Button(setTitle: "Зарегистрироваться!")
    private let forgotPasswordButton = Button(setTitle: "Забыли пароль?")
    private let backButton = Button(setTitle: "Назад")
    private let socialMediaLabel = SubTitleLabel(text: "Или вы можете подключиться с помощью:")
    private let socialMediaRectangleView = ComponentsBackground(cornerRadius: 16, corners: [.allCorners])
    
    // Используем новый класс AuthImages для создания логотипов
    private let appleLogo = AuthImages(imageName: "appleLogo")
    private let vkLogo = AuthImages(imageName: "vkLogo")
    private let googleLogo = AuthImages(imageName: "googleLogo")
    
    // Создаем SocialMediaStackView для выравнивания логотипов с отступами
    private lazy var socialMediaStackView: SocialMediaStackView = {
        return SocialMediaStackView(appleLogo: appleLogo, vkLogo: vkLogo, googleLogo: googleLogo)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        scrollView.delaysContentTouches = false
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        self.view.backgroundColor = Styles.Colors.appBackgoundColor
        
        setupScrollView()
        setupUI()
        setupConstraints()
    }
    
    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(scrollView) // Для вертикального скроллинга
        }
    }
    
    private func setupUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(subTitleLabel)
        contentView.addSubview(authRectangleView)
        contentView.addSubview(loginLabel)
        contentView.addSubview(loginTextField)
        contentView.addSubview(passwordLabel)
        contentView.addSubview(passwordTextField)
        contentView.addSubview(authButton)
        contentView.addSubview(socialMediaLabel)
        contentView.addSubview(socialMediaRectangleView)
        contentView.addSubview(socialMediaStackView) // Добавляем stackView для логотипов
        contentView.addSubview(registerButton)
        contentView.addSubview(forgotPasswordButton)
        contentView.addSubview(backButton)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().inset(40)
            make.top.equalToSuperview().offset(20) // Отступ сверху от contentView
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.leading.equalTo(titleLabel.snp.leading)
            make.trailing.equalTo(titleLabel.snp.trailing)
        }
        
        authRectangleView.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
        }
        
        loginLabel.snp.makeConstraints { make in
            make.top.equalTo(authRectangleView.snp.top).offset(30)
            make.leading.equalTo(authRectangleView.snp.leading).offset(30)
            make.trailing.equalTo(authRectangleView.snp.trailing).inset(20)
        }
        
        loginTextField.snp.makeConstraints { make in
            make.top.equalTo(loginLabel.snp.bottom).offset(15)
            make.leading.equalTo(authRectangleView.snp.leading).offset(20)
            make.trailing.equalTo(authRectangleView.snp.trailing).inset(20)
            make.height.equalTo(50)
        }
        
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(loginTextField.snp.bottom).offset(30)
            make.leading.equalTo(authRectangleView.snp.leading).offset(30)
            make.trailing.equalTo(authRectangleView.snp.trailing).inset(20)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(15)
            make.leading.equalTo(authRectangleView.snp.leading).offset(20)
            make.trailing.equalTo(authRectangleView.snp.trailing).inset(20)
            make.height.equalTo(50)
        }
        
        authButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.leading.equalTo(authRectangleView.snp.leading).offset(20)
            make.trailing.equalTo(authRectangleView.snp.trailing).inset(20)
            make.height.equalTo(50)
            make.bottom.equalTo(authRectangleView.snp.bottom).inset(30)
        }
        
        socialMediaLabel.snp.makeConstraints { make in
            make.top.equalTo(authRectangleView.snp.bottom).offset(30)
            make.leading.equalTo(titleLabel.snp.leading)
            make.trailing.equalTo(titleLabel.snp.trailing)
        }
        
        socialMediaRectangleView.snp.makeConstraints { make in
            make.top.equalTo(socialMediaLabel.snp.bottom).offset(30)
            make.leading.equalTo(authRectangleView.snp.leading)
            make.trailing.equalTo(authRectangleView.snp.trailing)
            make.height.equalTo(120)
        }
        
        socialMediaStackView.snp.makeConstraints { make in
            make.centerY.equalTo(socialMediaRectangleView.snp.centerY)
            make.centerX.equalTo(socialMediaRectangleView.snp.centerX)
        }
        
        registerButton.snp.makeConstraints { make in
            make.top.equalTo(socialMediaRectangleView.snp.bottom).offset(30)
            make.leading.equalTo(authRectangleView.snp.leading)
            make.trailing.equalTo(authRectangleView.snp.trailing)
            make.height.equalTo(50)
        }
        
        forgotPasswordButton.snp.makeConstraints { make in
            make.top.equalTo(registerButton.snp.bottom).offset(20)
            make.leading.equalTo(authRectangleView.snp.leading)
            make.trailing.equalTo(authRectangleView.snp.trailing)
            make.height.equalTo(50)
        }
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(forgotPasswordButton.snp.bottom).offset(20)
            make.leading.equalTo(authRectangleView.snp.leading)
            make.trailing.equalTo(authRectangleView.snp.trailing)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().inset(50)
        }
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func backButtonTapped() {
        let welcomeScreenVC = WelcomeScreenVC()
        navigationController?.pushViewController(welcomeScreenVC, animated: true)
    }
}


