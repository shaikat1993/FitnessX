//
//  AppCoordinator.swift
//  FitnessX
//
//  Created by Md Sadidur Rahman on 27/2/25.
//

import Foundation
import UIKit

final class AppCoordinator: FitnessBaseCoordinator {
    private let window: UIWindow
    private let authService: AuthServiceType
    
    init(window: UIWindow,
         authService: AuthServiceType) {
        self.window = window
        self.authService = authService
        
        super.init(navigationController: UINavigationController())
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    override func start() {
        if !UserDefaults.standard.bool(forKey: "hasOnboarded") {
            showCoordinator(.welcome)
        } else if !authService.isSignedin {
            loadSignin()
        } else {
            loadMainFlow()
        }
    }
    
    private func showCoordinator(_ type: CoordinatorType,
                                 removingCurrent current: CoordinatorType? = nil) {
        if let current = current {
            removeChild(current.key)
        }
        let coordinator = type.create(navigationController: navigationController,
                                      delegate: self)
        addChild(coordinator, 
                 with: type.key)
        coordinator.start()
    }
    
    private func loadSignin(){
        
    }
    private func loadMainFlow(){
        
    }
}

extension AppCoordinator: WelcomeCoordinatorDelegate {
    func welcomeDidRequestOnboarding() {
        showCoordinator(.onboarding,
                        removingCurrent: .welcome)
    }
}


extension AppCoordinator: OnboardingCoordinatorDelegate {
    func onboardingDidComplete() {
        showCoordinator(.signup,
                        removingCurrent: .onboarding)
    }
    
    private func loadSignup() {
        let coordinator = SignUpCoordinator(navigationController: navigationController)
        coordinator.delegate = self
        addChild(coordinator, with: "signup")
        coordinator.start()
    }
}

extension AppCoordinator: SignUpCoordinatorDelegate {
    func signUpDidComplete() {
        showCoordinator(.main, 
                        removingCurrent: .signup)
    }
    
    func signUpDidRequestLogin() {
        showCoordinator(.main,
                        removingCurrent: .signup)
    }
}
