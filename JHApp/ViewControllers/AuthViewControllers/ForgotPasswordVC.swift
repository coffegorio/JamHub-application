//
//  ForgotPasswordVC.swift
//  JHApp
//
//  Created by Егорио on 25.11.2024.
//

import UIKit
import SnapKit

final class ForgotPasswordVС: UIViewController {
    
    // MARK: - UI Elements
    
    private let titleLabel = TitleLabel(text: "Забыли пароль?")
    private let subTitleLabel = SubTitleLabel(text: "Его можно восстановить, введите свою электронную почту!")
    private let forgotPasswordBackground = ComponentsBackground(cornerRadius: 16, corners: [.allCorners])
    private let forgotPasswordLabel = DefaultLabel(text: "Электронная почта", fontSize: 18, weight: .regular)
    private let forgotPasswordTextField = TextField(
        placeholder: "Введите электронную почту",
        leftPadding: 10,
        cornerRadius: 12,
        roundedCorners: [.allCorners]
    )
    private let forgotPasswordButton = Button(setTitle: "Восстановить")
    private let backButton = Button(setTitle: "Назад!")
    
    // MARK: - Lifecycle
    
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
        
        // Добавляем все элементы на экран
        [titleLabel, subTitleLabel, forgotPasswordBackground,
         forgotPasswordLabel, forgotPasswordTextField,
         forgotPasswordButton, backButton].forEach { view.addSubview($0) }
    }
    
    private func setupActions() {
        // Настройка жестов и кнопок
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        forgotPasswordButton.addTarget(self, action: #selector(forgotPasswordButtonTapped), for: .touchUpInside)
        forgotPasswordButton.addTarget(self, action: #selector(dismissKeyboard), for: .touchDown)
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
        
        forgotPasswordBackground.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        forgotPasswordLabel.snp.makeConstraints { make in
            make.top.equalTo(forgotPasswordBackground).offset(30)
            make.leading.trailing.equalTo(forgotPasswordBackground).inset(40)
        }
        
        forgotPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(forgotPasswordLabel.snp.bottom).offset(20)
            make.leading.trailing.equalTo(forgotPasswordBackground).inset(20)
            make.height.equalTo(50)
        }
        
        forgotPasswordButton.snp.makeConstraints { make in
            make.top.equalTo(forgotPasswordTextField.snp.bottom).offset(20)
            make.leading.trailing.equalTo(forgotPasswordBackground).inset(20)
            make.bottom.equalTo(forgotPasswordBackground).inset(30)
        }
        
        backButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().inset(100)
        }
    }
    
    // MARK: - Actions
    
    @objc private func backButtonTapped() {
        let authScreenVC = AuthScreenVC()
        navigationController?.pushViewController(authScreenVC, animated: true)
    }
    
    @objc private func forgotPasswordButtonTapped() {
        guard let email = forgotPasswordTextField.text, Validator.isValidEmail(for: email) else {
            AlertManager.showInvalidEmailAlert(on: self)
            return
        }
        
        AuthService.shared.forgotPassword(with: email) { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                AlertManager.showErrorSendingPasswordReset(on: self, with: error)
            } else {
                AlertManager.showPasswordResetSent(on: self)
            }
        }
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}
