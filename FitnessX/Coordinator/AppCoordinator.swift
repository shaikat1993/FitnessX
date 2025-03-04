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
    private var currentCoordinator: Coordinator?
    
    init(window: UIWindow,
         authService: AuthServiceType) {
        self.window = window
        self.authService = authService
        // Create navigation controller
        let navigationController = UINavigationController()
        
        super.init(navigationController: navigationController)
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
    
    func showCoordinator(_ type: CoordinatorType, 
                                 removingCurrent current: CoordinatorType? = nil) {
        // First add new coordinator, then remove old one to prevent deallocation issues
        let coordinator = type.create(navigationController: navigationController, delegate: self)
        addChild(coordinator, with: type.key)
        currentCoordinator = coordinator
        coordinator.start()
        
        if let current = current {
            removeChild(current.key)
        }
    }
    
    private func loadSignin(){
        
    }
    private func loadMainFlow(){
        
    }
}

// MARK: - Coordinator Delegates
extension AppCoordinator: WelcomeCoordinatorDelegate {
    func welcomeDidRequestOnboarding() {
        showCoordinator(.onboarding,
                        removingCurrent: .welcome)
    }
}

extension AppCoordinator: OnboardingCoordinatorDelegate {
    func onboardingDidComplete() {
        showCoordinator(.signup(email: nil),
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
                        removingCurrent: .signup(email: nil))
    }
    
    func signUpDidRequestLogin() {
        showCoordinator(.main,
                        removingCurrent: .signup(email: nil))
    }
}
