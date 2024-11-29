//
//  UserTableViewCell.swift
//  JHApp
//
//  Created by Егорио on 29.11.2024.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    // Определяем элементы интерфейса для ячейки
    private let userNameLabel = UILabel()
    private let userStatusLabel = UILabel()
    
    // Инициализируем ячейку
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    // Настроим элементы интерфейса внутри ячейки
    private func setupUI() {
        userNameLabel.font = .boldSystemFont(ofSize: 16)
        userStatusLabel.font = .systemFont(ofSize: 14)
        
        contentView.addSubview(userNameLabel)
        contentView.addSubview(userStatusLabel)
        
        // Устанавливаем constraints с помощью SnapKit
        userNameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(10)
        }
        
        userStatusLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(userNameLabel.snp.bottom).offset(5)
        }
    }
    
    // Метод для обновления данных ячейки
    func configure(with user: User) {
        userNameLabel.text = user.nickname  // используем nickname вместо name
        userStatusLabel.text = user.email   // или любое другое свойство
    }
}
