//
//  AuthImages.swift
//  JHApp
//
//  Created by Егорио on 25.11.2024.
//

import UIKit

class AuthImages: UIImageView {
    
    // Инициализация с именем изображения
    init(imageName: String) {
        super.init(frame: .zero)
        self.image = UIImage(named: imageName)
        self.contentMode = .scaleAspectFit  // Устанавливаем .scaleAspectFit
        self.translatesAutoresizingMaskIntoConstraints = false
        
        // Добавляем ограничение ширины и высоты для логотипа
        self.heightAnchor.constraint(equalToConstant: 40).isActive = true // Высота 40
        self.widthAnchor.constraint(equalToConstant: 40).isActive = true // Ширина 40
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

