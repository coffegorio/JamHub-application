//
//  RegistrationVC.swift
//  JHApp
//
//  Created by Егорио on 25.11.2024.
//

import UIKit
import SnapKit

class RegistrationVC: UIViewController {

    // MARK: - UI Elements
    private let titleLabel = TitleLabel(text: "Регистрация")
    private let subTitleLabel = SubTitleLabel(text: "Зарегистрируйтесь, чтобы получить безграничный доступ к общению!")
    private let registrationBackground = ComponentsBackground(cornerRadius: 16, corners: [.allCorners])
    private let emailLabel = DefaultLabel(text: "Электронная почта", fontSize: 18, weight: .regular)
    private let emailTextField = TextField(placeholder: "Введите электронную почту", leftPadding: 10, cornerRadius: 12, roundedCorners: [.allCorners])
    private let passwordLabel = DefaultLabel(text: "Пароль", fontSize: 18, weight: .regular)
    private let passwordTextField = TextField(placeholder: "Введите пароль", leftPadding: 10, cornerRadius: 12, roundedCorners: [.allCorners])
    private let registrationButton = Button(setTitle: "Зарегистрироваться")
    private let backButton = Button(setTitle: "Назад!")

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupConstraints()
    }

    // MARK: - Setup UI
    private func configureUI() {
        // Скрыть навигационный бар
        navigationController?.setNavigationBarHidden(true, animated: false)

        // Убрать клавиатуру по тапу на экран
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)

        // Установить действия для кнопок
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)

        // Установить фоновый цвет
        view.backgroundColor = Styles.Colors.appBackgoundColor

        // Добавить элементы на экран
        view.addSubview(titleLabel)
        view.addSubview(subTitleLabel)
        view.addSubview(registrationBackground)
        registrationBackground.addSubview(emailLabel)
        registrationBackground.addSubview(emailTextField)
        registrationBackground.addSubview(registrationButton)
        registrationBackground.addSubview(passwordLabel)
        registrationBackground.addSubview(passwordTextField)
        view.addSubview(backButton)
    }

    // MARK: - Setup Constraints
    private func setupConstraints() {
        // Title Label
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.trailing.equalToSuperview().inset(40)
        }

        // Subtitle Label
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.leading.trailing.equalTo(titleLabel)
        }

        // Registration Background
        registrationBackground.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(20)
        }

        // Email Label
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(registrationBackground.snp.top).offset(30)
            make.leading.equalTo(registrationBackground).offset(20)
            make.trailing.equalTo(registrationBackground).inset(20)
        }

        // Email TextField
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(20)
            make.leading.trailing.equalTo(registrationBackground).inset(20)
            make.height.equalTo(50)
        }

        // Password Label
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.leading.equalTo(registrationBackground).offset(20)
            make.trailing.equalTo(registrationBackground).inset(20)
        }

        // Password TextField
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(20)
            make.leading.trailing.equalTo(registrationBackground).inset(20)
            make.height.equalTo(50)
        }

        // Registration Button
        registrationButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.leading.trailing.equalTo(registrationBackground).inset(20)
            make.bottom.equalTo(registrationBackground.snp.bottom).inset(30) // Это важно!
        }

        // Back Button
        backButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().inset(100)
        }
    }

    // MARK: - Actions
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

