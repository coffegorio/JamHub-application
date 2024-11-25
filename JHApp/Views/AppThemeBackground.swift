//
//  appThemeBackground.swift
//  JHApp
//
//  Created by Егорио on 24.11.2024.
//

import UIKit

class AppThemeBackground: UIView {

    private var cornerRadius: CGFloat = 0
    private var corners: UIRectCorner = []

    init(cornerRadius: CGFloat, corners: UIRectCorner) {
        super.init(frame: .zero)
        
        self.cornerRadius = cornerRadius
        self.corners = corners
        self.backgroundColor = Styles.Colors.appThemeColor
        self.layer.masksToBounds = true // Включаем обрезку по границам
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Применяем закругление углов только после задания размеров
        let path = UIBezierPath(
            roundedRect: self.bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)
        )
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}