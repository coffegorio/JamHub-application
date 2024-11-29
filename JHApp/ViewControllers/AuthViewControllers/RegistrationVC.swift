//
//  RegistrationVC.swift
//  JHApp
//
//  Created by Егорио on 25.11.2024.
//

import UIKit
import SnapKit

final class RegistrationVC: UIViewController {

    // MARK: - UI Elements
    
    private let titleLabel = TitleLabel(text: "Регистрация")
    private let subTitleLabel = SubTitleLabel(text: "Зарегистрируйтесь, чтобы получить безграничный доступ к общению!")
    private let registrationBackground = ComponentsBackground(cornerRadius: 16, corners: [.allCorners])
    private let emailLabel = DefaultLabel(text: "Электронная почта", fontSize: 18, weight: .regular)
    private let emailTextField = TextField(
        placeholder: "Введите электронную почту",
        leftPadding: 10,
        cornerRadius: 12,
        roundedCorners: [.allCorners]
    )
    private let passwordLabel = DefaultLabel(text: "Пароль", fontSize: 18, weight: .regular)
    private let passwordTextField = TextField(
        placeholder: "Введите пароль",
        leftPadding: 10,
        cornerRadius: 12,
        roundedCorners: [.allCorners]
    )
    private let registrationButton = Button(setTitle: "Зарегистрироваться")
    private let backButton = Button(setTitle: "Назад!")

    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupActions()
        setupConstraints()
    }

    // MARK: - Setup
    
    private func setupView() {
        view.backgroundColor = Styles.Colors.appBackgoundColor
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        // Добавление элементов в view
        view.addSubview(titleLabel)
        view.addSubview(subTitleLabel)
        view.addSubview(registrationBackground)
        registrationBackground.addSubview(emailLabel)
        registrationBackground.addSubview(emailTextField)
        registrationBackground.addSubview(passwordLabel)
        registrationBackground.addSubview(passwordTextField)
        registrationBackground.addSubview(registrationButton)
        view.addSubview(backButton)
    }
    
    private func setupActions() {
        // Настройка жестов и кнопок
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        registrationButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        registrationButton.addTarget(self, action: #selector(dismissKeyboard), for: .touchDown)
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.trailing.equalToSuperview().inset(40)
        }

        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.leading.trailing.equalTo(titleLabel)
        }

        registrationBackground.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(20)
        }

        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(registrationBackground).offset(30)
            make.leading.trailing.equalTo(registrationBackground).inset(20)
        }

        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(20)
            make.leading.trailing.equalTo(registrationBackground).inset(20)
            make.height.equalTo(50)
        }

        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.leading.trailing.equalTo(registrationBackground).inset(20)
        }

        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(20)
            make.leading.trailing.equalTo(registrationBackground).inset(20)
            make.height.equalTo(50)
        }

        registrationButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.leading.trailing.equalTo(registrationBackground).inset(20)
            make.bottom.equalTo(registrationBackground).inset(30)
        }

        backButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().inset(100)
        }
    }

    // MARK: - Actions
    
    @objc private func registerButtonTapped() {
        let registerUserRequest = RegisterUserRequest(
            email: emailTextField.text ?? "",
            password: passwordTextField.text ?? ""
        )

        // Проверка email
        if !Validator.isValidEmail(for: registerUserRequest.email) {
            AlertManager.showInvalidEmailAlert(on: self)
            return
        }

        // Проверка пароля
        if !Validator.isPasswordValid(for: registerUserRequest.password) {
            AlertManager.showInvalidPasswordAlert(on: self)
            return
        }

        // Генерация никнейма
        let defaultNickname = "User\(Int.random(in: 1000...9999))"

        AuthService.shared.registerUser(with: registerUserRequest, nickname: defaultNickname) { [weak self] wasRegistered, error in
            guard let self = self else { return }
            if let error = error {
                AlertManager.showRegistrationErrorAlert(on: self, with: error)
                return
            }
            if wasRegistered {
                (self.view.window?.windowScene?.delegate as? SceneDelegate)?.checkAuthentication() ??
                AlertManager.showRegistrationErrorAlert(on: self)
            }
        }
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}


