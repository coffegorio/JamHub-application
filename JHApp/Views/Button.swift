//
//  Button.swift
//  JHApp
//
//  Created by Егорио on 24.11.2024.
//

import UIKit

class Button: UIButton {
    
    init(setTitle: String) {
        super.init(frame: .zero)
        
        self.setTitle(setTitle, for: .normal)
        self.setTitleColor(Styles.Colors.primaryColor, for: .normal)
        self.backgroundColor = Styles.Colors.appThemeColor
        self.layer.cornerRadius = 15
        self.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        
        self.addTarget(self, action: #selector(buttonPressed), for: .touchDown)
        self.addTarget(self, action: #selector(buttonReleased), for: .touchUpInside)
        self.addTarget(self, action: #selector(buttonReleased), for: .touchUpOutside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func buttonPressed() {
        UIView.animate(withDuration: 0.05) {
            self.transform = CGAffineTransform(scaleX: 0.90, y: 0.90)
        }
    }
    
    @objc private func buttonReleased() {
        UIView.animate(withDuration: 0.05) {
            self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
    }
}
