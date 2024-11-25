//
//  DefaultLabel.swift
//  JHApp
//
//  Created by Егорио on 25.11.2024.
//

import UIKit

class DefaultLabel: UILabel {

    init(text: String, fontSize: CGFloat, weight: UIFont.Weight) {
        super.init(frame: .zero)
        
        Styles.LabelSettings.configureDefaultLabel(self)
        self.text = text
        self.textColor = Styles.Colors.primaryColor
        self.font = UIFont.systemFont(ofSize: fontSize, weight: weight)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

