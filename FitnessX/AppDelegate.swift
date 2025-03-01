//
//  AppDelegate.swift
//  FitnessX
//
//  Created by Md Sadidur Rahman on 5/1/25.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    private var appCoordinator: AppCoordinator?
    private var authService: AuthServiceType?

    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Reset user defaults for testing
        UserDefaults.standard.set(false, forKey: "hasOnboarded")
        
        window = UIWindow(frame: UIScreen.main.bounds)
        guard let window = window else { return false }
        
        //initialise app coordinator
        appCoordinator = AppCoordinator(window: window,
                                       authService: AuthService.shared)
        appCoordinator?.start()
        return true
    }
}

