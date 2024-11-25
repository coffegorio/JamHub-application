//
//  TitleLabel.swift
//  JHApp
//
//  Created by Егорио on 24.11.2024.
//

import UIKit

class TitleLabel: UILabel {

    init(text: String) {
        super.init(frame: .zero)
        
        Styles.LabelSettings.configureDefaultLabel(self)
        self.text = text
        self.textColor = Styles.Colors.primaryColor
        self.font = Styles.Fonts.titleFont
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
