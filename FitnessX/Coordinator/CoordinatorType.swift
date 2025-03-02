//
//  CoordinatorType.swift
//  FitnessX
//
//  Created by Md Sadidur Rahman on 2/3/25.
//

import Foundation
import UIKit

enum CoordinatorType {
    case welcome
    case onboarding
    case signup
    case signin
    case main
    
    var key: String {
        switch self {
        case .welcome: return "welcome"
        case .onboarding: return "onboarding"
        case .signup: return "signup"
        case .signin: return "signin"
        case .main: return "main"
        }
    }
    
    func create(navigationController: UINavigationController, delegate: Any) -> Coordinator {
        switch self {
        case .welcome:
            let coordinator = WelcomeCoordinator(navigationController: navigationController)
            coordinator.delegate = delegate as? WelcomeCoordinatorDelegate
            return coordinator
        case .onboarding:
            let coordinator = OnboardingCoordinator(navigationController: navigationController)
            coordinator.delegate = delegate as? OnboardingCoordinatorDelegate
            return coordinator
        case .signup:
            let coordinator = SignUpCoordinator(navigationController: navigationController)
            coordinator.delegate = delegate as? SignUpCoordinatorDelegate
            return coordinator
        case .signin:
            break
//            let coordinator = SignInCoordinator(navigationController: navigationController)
//            coordinator.delegate = delegate as? SignInCoordinatorDelegate
//            return coordinator
        case .main:
            break
//            let coordinator = MainFlowCoordinator(navigationController: navigationController)
//            coordinator.delegate = delegate as? MainFlowCoordinatorDelegate
//            return coordinator
        }
        // need to delete it after implemneting fully
        let coordinator = WelcomeCoordinator(navigationController: navigationController)
        coordinator.delegate = delegate as? WelcomeCoordinatorDelegate
        return coordinator
    }
}
