//
//  ProfileScreenVC.swift
//  JHApp
//
//  Created by Егорио on 28.11.2024.
//

import UIKit
import SnapKit

protocol ProfileScreenVCDelegate: AnyObject {
    func didUpdateNickname(_ nickname: String)
}

class ProfileScreenVC: UIViewController {

    private let profileAvatar = AvatarButton(imageName: "avatarView", size: 100)
    private let userNickName = SubTitleLabel(text: "")
    private let nicknameTextField = UITextField()
    private let updateNicknameButton = UIButton(type: .system)
    
    weak var delegate: ProfileScreenVCDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.setNavigationBarHidden(true, animated: false)
        
        self.view.backgroundColor = Styles.Colors.appBackgoundColor
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        setupUI()
        setupConstraints()
        fetchNickname()
    }
    
    private func setupUI() {
        view.addSubview(profileAvatar)
        view.addSubview(userNickName)
        view.addSubview(nicknameTextField)
        view.addSubview(updateNicknameButton)
        
        updateNicknameButton.setTitle("Сменить никнейм", for: .normal)
        updateNicknameButton.setTitleColor(Styles.Colors.appThemeColor, for: .normal)
        updateNicknameButton.addTarget(self, action: #selector(updateNicknameTapped), for: .touchUpInside)
        
        nicknameTextField.placeholder = "Введите новый никнейм"
        nicknameTextField.backgroundColor = Styles.Colors.componentsBackgroundColor
        nicknameTextField.layer.cornerRadius = 12
        nicknameTextField.textAlignment = .center
        nicknameTextField.autocorrectionType = .no
        nicknameTextField.autocapitalizationType = .none
    }
    
    private func setupConstraints() {
        profileAvatar.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(70)
            make.centerX.equalToSuperview()
        }
        
        userNickName.snp.makeConstraints { make in
            make.top.equalTo(profileAvatar.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }
        
        nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(userNickName.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(250)
            make.height.equalTo(40)
        }

        updateNicknameButton.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextField.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func updateNicknameTapped() {
        guard let newNickname = nicknameTextField.text, !newNickname.isEmpty else {
            print("New nickname cannot be empty")
            return
        }
        
        AuthService.shared.updateNickname(to: newNickname) { [weak self] success, error in
            guard let self = self else { return }
            if success {
                print("Nickname updated successfully")
                self.userNickName.text = "\(newNickname)"
                self.nicknameTextField.text = "" // Очищаем поле ввода
                
                // Уведомляем делегата, чтобы обновить никнейм на HomeScreenVC
                self.delegate?.didUpdateNickname(newNickname)
            } else if let error = error {
                print("Failed to update nickname: \(error.localizedDescription)")
            }
        }
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
}
