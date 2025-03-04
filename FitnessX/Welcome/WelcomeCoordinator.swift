//
//  WelcomeCoordinator.swift
//  FitnessX
//
//  Created by Md Sadidur Rahman on 1/3/25.
//

import UIKit

protocol WelcomeCoordinatorDelegate: AnyObject {
    func welcomeDidRequestOnboarding()
}

class WelcomeCoordinator: FitnessBaseCoordinator {
    weak var delegate: WelcomeCoordinatorDelegate?
    private var viewModel: WelcomeViewModel? // Strong reference
    
    override func start() {
        let storyboard = UIStoryboard(name: "Onboarding", 
                                      bundle: nil)
        guard let welcomeVC = storyboard.instantiateViewController(withIdentifier: "WelcomeVC") as? WelcomeVC else {
            return
        }
        
        // Configure with ViewModel
        let viewModel = WelcomeViewModel()
        viewModel.coordinator = self
        welcomeVC.configure(with: viewModel)
        self.viewModel = viewModel // Keep strong reference
        
        // Set as root using NavigationManager
        NavigationManager.shared.setRoot(welcomeVC)
    }
    
    func showOnboarding() {
        delegate?.welcomeDidRequestOnboarding()
    }
}
