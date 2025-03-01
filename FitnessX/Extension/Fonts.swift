//
//  Fonts.swift
//  FitnessX
//
//  Created by Md Sadidur Rahman on 5/1/25.
//

import UIKit

enum AppFont {
    enum Poppins {
        static func regular(size: CGFloat) -> UIFont {
            return UIFont(name: "PoppinsRegular", size: size) ?? .systemFont(ofSize: size)
        }
        
        static func semiBold(size: CGFloat) -> UIFont {
            return UIFont(name: "PoppinsSemibold", size: size) ?? .systemFont(ofSize: size, weight: .semibold)
        }
        
        static func medium(size: CGFloat) -> UIFont {
            return UIFont(name: "PoppinsMedium", size: size) ?? .systemFont(ofSize: size, weight: .medium)
        }
        
        static func bold(size: CGFloat) -> UIFont {
            return UIFont(name: "PoppinsBold", size: size) ?? .systemFont(ofSize: size, weight: .bold)
        }
    }
}
