//
//  HomeScreenVC.swift
//  JHApp
//
//  Created by Егорио on 27.11.2024.
//

import UIKit
import SnapKit

class HomeScreenVC: UIViewController, ProfileScreenVCDelegate {

    // MARK: - UI Elements
    private let avatarButton = AvatarButton(imageName: "avatarView", size: 60)
    private let addFriendButton = Button(setTitle: "Добавить друга")
    private let greetingLabel = TitleLabel(text: "")
    private let userNickName = SubTitleLabel(text: "")
    private let listOnlineFriendsLabel = DefaultLabel(text: "Ваши друзья в сети:", fontSize: 20, weight: .regular)
    
    private let tableView = UITableView()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Styles.Colors.appBackgoundColor
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        setupUI()
        setupConstraints()
        setupActions()
        
        updateGreeting()
        fetchNickname()
    }

    // MARK: - Setup UI
    private func setupUI() {
        view.addSubview(greetingLabel)
        view.addSubview(avatarButton)
        view.addSubview(addFriendButton)
        view.addSubview(userNickName)
        view.addSubview(listOnlineFriendsLabel)
        
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
        
        addFriendButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().inset(40)
            make.height.equalTo(50)
            make.top.equalTo(userNickName.snp.bottom).offset(30)
        }
        
        listOnlineFriendsLabel.snp.makeConstraints { make in
            make.top.equalTo(addFriendButton.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().inset(40)
        }
    }

    // MARK: - Actions
    @objc private func avatarButtonTapped() {
        UIView.animate(withDuration: 0.1,
                       animations: {
                           self.avatarButton.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                       },
                       completion: { _ in
                           UIView.animate(withDuration: 0.1) {
                               self.avatarButton.transform = CGAffineTransform.identity
                           }
                       })
        
        let profileScreenVC = ProfileScreenVC()
        profileScreenVC.delegate = self
        navigationController?.pushViewController(profileScreenVC, animated: true)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    // MARK: - Update Greeting
    private func updateGreeting() {
        greetingLabel.text = GreetingModel.getGreeting()
    }

    // MARK: - Fetch User Nickname
    private func fetchNickname() {
        AuthService.shared.fetchUserCompletion { [weak self] user, error in
            guard let self = self else {
                print("HomeScreenVC deallocated before completion.")
                return
            }
            
            if let error = error {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Ошибка", message: error.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "ОК", style: .default))
                    self.present(alert, animated: true)
                }
                return
            }
            
            if let user = user {
                DispatchQueue.main.async {
                    self.userNickName.text = user.nickname.isEmpty ? "Пользователь" : user.nickname
                }
            }
        }
    }

    // MARK: - ProfileScreenVCDelegate
    func didUpdateNickname(_ nickname: String) {
        DispatchQueue.main.async {
            self.userNickName.text = nickname
        }
    }
    
    private func setupActions() {
        addFriendButton.addTarget(self, action: #selector(moveToAddFriendVC), for: .touchUpInside)
    }
    
    @objc private func moveToAddFriendVC() {
        let addFriendVC = AddFriendVC()
        navigationController?.pushViewController(addFriendVC, animated: true)
    }
}
