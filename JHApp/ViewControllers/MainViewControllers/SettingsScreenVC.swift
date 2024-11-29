//
//  SettingsScreenVC.swift
//  JHApp
//
//  Created by Егорио on 27.11.2024.
//

import UIKit
import SnapKit

class SettingsScreenVC: UIViewController {

    private let label = TitleLabel(text: "Экран настроек")
    private let logoutButton = Button(setTitle: "Выйти из аккаунта")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = Styles.Colors.appBackgoundColor
        
        
        setupUI()
        setupConstraints()
        
        logoutButton.backgroundColor = Styles.Colors.appBackgoundColor
        logoutButton.setTitleColor(.systemBlue, for: .normal)
        logoutButton.addTarget(self, action: #selector(didTapLogout), for: .touchUpInside)

    }
    
    private func setupUI() {
        
        view.addSubview(label)
        view.addSubview(logoutButton)
        
    }
    
    private func setupConstraints() {
        
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        logoutButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(100)
            make.centerX.equalToSuperview()
            make.height.equalTo(100)
            make.width.equalTo(200)
        }

    }
    
    @objc private func didTapLogout() {
            AuthService.shared.signOut { [weak self] error in
                guard let self = self else { return }
                if let error = error {
                    AlertManager.showLogoutError(on: self, with: error)
                    return
                }
    
                if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                    sceneDelegate.checkAuthentication()
                }
            }
        }

}
