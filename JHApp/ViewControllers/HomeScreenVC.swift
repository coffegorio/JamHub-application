//
//  HomeScreenVC.swift
//  JHApp
//
//  Created by Егорио on 27.11.2024.
//

import UIKit
import SnapKit

class HomeScreenVC: UIViewController, ProfileScreenVCDelegate {

    // UI элементы
    private let avatarButton = AvatarButton(imageName: "avatarView", size: 60)
    private let greetingLabel = TitleLabel(text: "")
    private let userNickName = SubTitleLabel(text: "")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = Styles.Colors.appBackgoundColor
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        setupUI()
        setupConstraints()
        
        updateGreeting()
        fetchNickname()
    }
    
    private func setupUI() {
        view.addSubview(greetingLabel)
        view.addSubview(avatarButton)
        view.addSubview(userNickName)
        
        avatarButton.addTarget(self, action: #selector(avatarButtonTapped), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        greetingLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(40)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
        
        avatarButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(-30)
            make.trailing.equalToSuperview().inset(50)
        }
        
        userNickName.snp.makeConstraints { make in
            make.leading.equalTo(greetingLabel.snp.leading)
            make.top.equalTo(greetingLabel.snp.bottom).offset(20)
        }
    }
    
    @objc func avatarButtonTapped() {
        let profileScreenVC = ProfileScreenVC()
        profileScreenVC.delegate = self  // Устанавливаем делегат
        navigationController?.pushViewController(profileScreenVC, animated: true)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func updateGreeting() {
        greetingLabel.text = GreetingModel.getGreeting()
    }
    
    private func fetchNickname() {
        AuthService.shared.fetchUserCompletion { [weak self] user, error in
            guard let self = self else { return }
            if let error = error {
                print("Failed to fetch user: \(error.localizedDescription)")
                return
            }
            if let user = user {
                self.userNickName.text = "\(user.nickname)"
            }
        }
    }
    
    // Реализация делегата для обновления никнейма
    func didUpdateNickname(_ nickname: String) {
        // Обновляем никнейм на главном экране
        userNickName.text = nickname
    }
}







// Функция выхода из аккаунта
//    @objc private func didTapLogout() {
//        AuthService.shared.signOut { [weak self] error in
//            guard let self = self else { return }
//            if let error = error {
//                AlertManager.showLogoutError(on: self, with: error)
//                return
//            }
//
//            if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
//                sceneDelegate.checkAuthentication()
//            }
//        }
//    }
