//
//  GradientView.swift
//  FitnessX
//
//  Created by Md Sadidur Rahman on 7/1/25.
//

import UIKit

// MARK: - UIColor Extension for Hex
extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

// MARK: - UIView Gradient Extension
extension UIView {
    func applyGradient(hexColors: [String], startPoint: CGPoint = CGPoint(x: 0.0, y: 0.5), endPoint: CGPoint = CGPoint(x: 1.0, y: 0.5)) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = hexColors.map { UIColor(hex: $0).cgColor }
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        
        // Remove previous gradient layers if any
        layer.sublayers?.forEach { layer in
            if layer is CAGradientLayer {
                layer.removeFromSuperlayer()
            }
        }
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
