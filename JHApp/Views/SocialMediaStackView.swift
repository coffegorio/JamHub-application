//
//  SocialMediaStackView.swift
//  JHApp
//
//  Created by Егорио on 25.11.2024.
//

import UIKit

class SocialMediaStackView: UIStackView {
    
    init(appleLogo: UIImageView, vkLogo: UIImageView, googleLogo: UIImageView) {
        super.init(frame: .zero)
        
        self.axis = .horizontal
        self.spacing = 50 // Отступы между логотипами
        self.alignment = .center
        self.translatesAutoresizingMaskIntoConstraints = false
        
        // Добавляем логотипы в stackView
        self.addArrangedSubview(appleLogo)
        self.addArrangedSubview(vkLogo)
        self.addArrangedSubview(googleLogo)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
