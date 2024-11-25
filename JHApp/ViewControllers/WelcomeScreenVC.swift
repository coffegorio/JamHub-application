//
//  WelcomeScreen.swift
//  JHApp
//
//  Created by Егорио on 24.11.2024.
//

import UIKit
import SnapKit

class WelcomeScreenVC: UIViewController {

    private let titleBackground = AppThemeBackground(cornerRadius: 16, corners: [.topRight, .bottomRight, .bottomLeft])
    private let appNameLabel = TitleLabel(text: "JamHub")
    private let titleLabel = TitleLabel(text: "- ваш лучший помощник в организации встреч и событий!")
    private let subTitleLabel = SubTitleLabel(text: "Мы предлагаем простое и удобное решение для планирования встреч с друзьями, коллегами или единомышленниками.")
    private let startButton = Button(setTitle: "Поехали!")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.hidesBackButton = true
        self.view.backgroundColor = Styles.Colors.appBackgoundColor
        
        setupUI()
        setupConstraints()
        
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
    }
    
    private func setupUI() {
        self.view.addSubview(titleBackground)
        self.view.addSubview(appNameLabel)
        self.view.addSubview(titleLabel)
        self.view.addSubview(subTitleLabel)
        self.view.addSubview(startButton)
    }
    
    private func setupConstraints() {
        
        titleBackground.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.equalToSuperview().offset(40)
            make.width.equalTo(160)
            make.height.equalTo(60)
        }
        
        appNameLabel.snp.makeConstraints { make in
            make.centerX.equalTo(titleBackground.snp.centerX)
            make.centerY.equalTo(titleBackground.snp.centerY)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleBackground.snp.leading)
            make.trailing.equalToSuperview().inset(40)
            make.top.equalTo(titleBackground.snp.bottom).offset(20)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.leading)
            make.trailing.equalToSuperview().inset(40)
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
        }
        
        startButton.snp.makeConstraints { make in
            make.leading.equalTo(titleBackground.snp.leading)
            make.bottom.equalToSuperview().inset(100)
            make.width.equalTo(150)
            make.height.equalTo(50)
        }
    }
    
    @objc private func startButtonTapped() {
        let authScreen = AuthScreenVC()
        navigationController?.pushViewController(authScreen, animated: true)
    }

}
