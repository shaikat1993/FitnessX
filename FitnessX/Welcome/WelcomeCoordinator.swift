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
        
        // Set as root
        navigationController.setViewControllers([welcomeVC],
                                                animated: true)
    }
    
    func showOnboarding() {
        delegate?.welcomeDidRequestOnboarding()
    }
}
