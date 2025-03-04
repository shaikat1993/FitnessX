//
//  NavigationTransition.swift
//  FitnessX
//
//  Created by Md Sadidur Rahman on 4/3/25.
//

import Foundation
import UIKit

enum NavigationTransition{
    case push(animated: Bool)
    case present(style: PresentationStyle)
    case panModal
    case dismiss(animated: Bool)
    case pop(animated: Bool)
    
    enum PresentationStyle {
        case fullScreen
        case overCurrentContext
        case overFullScreen
        case custom(UIModalPresentationStyle)
    }
}
