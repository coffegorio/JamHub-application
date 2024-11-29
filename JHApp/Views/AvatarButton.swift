//
//  AvatarView.swift
//  JHApp
//
//  Created by Егорио on 28.11.2024.
//

import UIKit

class AvatarButton: UIButton {
    
    // Инициализация с возможностью передачи размеров
    init(imageName: String, size: CGFloat) {
        super.init(frame: .zero)
        
        let image = UIImage(named: imageName)
        self.setImage(image, for: .normal)
        self.imageView?.contentMode = .scaleAspectFill
        self.translatesAutoresizingMaskIntoConstraints = false
        
        // Настройка изображения (круглая форма)
        self.layer.cornerRadius = size / 2
        self.clipsToBounds = true
        
        // Установка размеров кнопки
        self.widthAnchor.constraint(equalToConstant: size).isActive = true
        self.heightAnchor.constraint(equalToConstant: size).isActive = true
        
        // Устанавливаем центрирование изображения
        self.contentHorizontalAlignment = .center
        self.contentVerticalAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


