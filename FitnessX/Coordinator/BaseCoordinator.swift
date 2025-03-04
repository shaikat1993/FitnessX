//
//  BaseCoordinator.swift
//  FitnessX
//
//  Created by Md Sadidur Rahman on 27/2/25.
//

import UIKit

class FitnessBaseCoordinator: Coordinator {
    let navigationController: UINavigationController
    var childCoordinators: [String: Coordinator] = [:]
    weak var parentCoordinator: Coordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        setupNavigationBar()
        NavigationManager.shared.setup(with: navigationController)
    }
    
    private func setupNavigationBar() {
        // Show navigation bar
//        let appearance = UINavigationBarAppearance()
//        appearance.configureWithOpaqueBackground()
//        appearance.backgroundColor = .systemBackground
//        appearance.shadowColor = .clear
//        
//        navigationController.navigationBar.standardAppearance = appearance
//        navigationController.navigationBar.scrollEdgeAppearance = appearance
        
        // Hide navigation bar
        navigationController.setNavigationBarHidden(true, 
                                                    animated: false)
        navigationController.navigationBar.isHidden = true
    }
    
    func start() {
        fatalError("Subclasses must implement start()")
    }
}
