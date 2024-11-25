//
//  CustomRoundedCorners.swift
//  JHApp
//
//  Created by Егорио on 24.11.2024.
//

import UIKit

extension UIView {
    /// Устанавливает скругленные углы для указанных сторон
    /// - Parameters:
    ///   - radius: Радиус скругления
    ///   - corners: Углы, которые нужно скруглить
    func roundCorners(_ radius: CGFloat, corners: UIRectCorner) {
        let path = UIBezierPath(
            roundedRect: self.bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}
