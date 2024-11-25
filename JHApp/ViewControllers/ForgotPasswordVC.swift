//
//  ForgotPasswordVC.swift
//  JHApp
//
//  Created by Егорио on 25.11.2024.
//

import UIKit
import SnapKit

class ForgotPasswordVC: UIViewController {
    
    private let titleLabel = TitleLabel(text: "Забыли пароль?")
    private let subTitleLabel = SubTitleLabel(text: "Его можно восстановить, введите свою электронную почту!")
    private let forgotPasswordBackground = ComponentsBackground(cornerRadius: 16, corners: [.allCorners])
    private let forgotPasswordLabel = DefaultLabel(text: "Электронная почта", fontSize: 18, weight: .regular)
    private let forgotPasswordTextField = TextField(placeholder: "Введите электронную почту", leftPadding: 10, cornerRadius: 12, roundedCorners: [.allCorners])
    private let forgotPasswordButton = Button(setTitle: "Восстановить")
    private let backButton = Button(setTitle: "Назад!")

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.setNavigationBarHidden(true, animated: false)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        self.view.backgroundColor = Styles.Colors.appBackgoundColor
     
        setupUI()
        setupConstraints()
        
    }
    
    private func setupUI() {
        self.view.addSubview(titleLabel)
        self.view.addSubview(subTitleLabel)
        self.view.addSubview(forgotPasswordBackground)
        self.view.addSubview(forgotPasswordLabel)
        self.view.addSubview(forgotPasswordTextField)
        self.view.addSubview(forgotPasswordButton)
        self.view.addSubview(backButton)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().inset(40)
        }

        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.leading.equalTo(titleLabel.snp.leading)
            make.trailing.equalTo(titleLabel.snp.trailing)
        }

        forgotPasswordBackground.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
        }

        forgotPasswordLabel.snp.makeConstraints { make in
            make.top.equalTo(forgotPasswordBackground.snp.top).offset(30)
            make.leading.equalTo(forgotPasswordBackground.snp.leading).offset(40)
            make.trailing.equalTo(forgotPasswordBackground.snp.trailing).inset(40)
        }

        forgotPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(forgotPasswordLabel.snp.bottom).offset(20)
            make.leading.equalTo(forgotPasswordBackground.snp.leading).offset(20)
            make.trailing.equalTo(forgotPasswordBackground.snp.trailing).inset(20)
            make.height.equalTo(50)
        }

        forgotPasswordButton.snp.makeConstraints { make in
            make.top.equalTo(forgotPasswordTextField.snp.bottom).offset(20)
            make.leading.equalTo(forgotPasswordBackground.snp.leading).offset(20)
            make.trailing.equalTo(forgotPasswordBackground.snp.trailing).inset(20)
            make.bottom.equalTo(forgotPasswordBackground.snp.bottom).inset(30) // Это важно
        }

        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().inset(100)
        }
    }


    @objc private func backButtonTapped() {
        let authScreenVC = AuthScreenVC()
        navigationController?.pushViewController(authScreenVC, animated: true)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
