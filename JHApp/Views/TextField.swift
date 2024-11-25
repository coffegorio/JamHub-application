//
//  TextField.swift
//  JHApp
//
//  Created by Егорио on 25.11.2024.
//

import UIKit

class TextField: UITextField {
    
    private let placeholderText: String
    private let leftPadding: CGFloat
    private let cornerRadius: CGFloat
    private let roundedCorners: UIRectCorner
    
    init(placeholder: String, leftPadding: CGFloat, cornerRadius: CGFloat, roundedCorners: UIRectCorner) {
        self.placeholderText = placeholder
        self.leftPadding = leftPadding
        self.cornerRadius = cornerRadius
        self.roundedCorners = roundedCorners
        
        super.init(frame: .zero)
        
        self.placeholder = placeholder
        self.textColor = .lightGray
        self.textAlignment = .left
        self.backgroundColor = Styles.Colors.appBackgoundColor
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: leftPadding, height: 1))
        self.leftView = paddingView
        self.leftViewMode = .always

        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Применяем скругление углов через расширение
        self.roundCorners(cornerRadius, corners: roundedCorners)
    }
    
}
