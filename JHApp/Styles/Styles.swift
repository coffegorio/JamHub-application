//
//  Styles.swift
//  JHApp
//
//  Created by Егорио on 24.11.2024.
//

import UIKit

struct Styles {
    
    struct Colors {
        static let primaryColor = UIColor.white
        static let appBackgoundColor = UIColor(hex: "#0A0A0A")
        static let appThemeColor = UIColor(hex: "#F77D8E")
        static let componentsBackgroundColor = UIColor(hex: "#242222")
    }
    
    struct Fonts {
        static let titleFont = UIFont.systemFont(ofSize: 32, weight: .bold)
        static let subTitleFont = UIFont.systemFont(ofSize: 24, weight: .regular)
        static let labelFont = UIFont.systemFont(ofSize: 21, weight: .regular)
    }
    
    struct LabelSettings {
            static func configureDefaultLabel(_ label: UILabel) {
                label.numberOfLines = 0
                label.lineBreakMode = .byWordWrapping
            }
        }
    
}
