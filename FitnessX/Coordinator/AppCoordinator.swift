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
            loadWelcome()
        } else if !authService.isSignedin {
            loadSignin()
        } else {
            loadMainFlow()
        }
    }
    
    private func loadWelcome(){
        let coordinator = WelcomeCoordinator(navigationController: navigationController)
        coordinator.delegate = self
        addChild(coordinator, with: "welcome")
        coordinator.start()
    }
    
    private func loadSignin(){
        
    }
    private func loadMainFlow(){
        
    }
}

extension AppCoordinator: WelcomeCoordinatorDelegate {
    func welcomeDidRequestOnboarding() {
        //remove welcome coordinator
        removeChild("welcome")
        
        
        // showOnboarding
        let coordinator = OnboardingCoordinator(navigationController: navigationController)
        coordinator.delegate = self
        addChild(coordinator, with: "onboarding")
        coordinator.start()
    }
}


extension AppCoordinator: OnboardingCoordinatorDelegate {
    func onboardingDidComplete() {
        removeChild("onboarding")
        
        //loadSignup
        loadSignup()
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
        removeChild("signup")
        //loadMainFlow()
    }
    
    func signUpDidRequestLogin() {
        removeChild("signup")
        //loadLogin()
    }
}
