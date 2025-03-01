//
//  BaseCoordinator.swift
//  FitnessX
//
//  Created by Md Sadidur Rahman on 27/2/25.
//

import Foundation
import UIKit

class FitnessBaseCoordinator: Coordinator {
    let navigationController: UINavigationController
    var childCoordinators: [String: Coordinator] = [:]
    weak var parentCoordinator: Coordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemBackground
        appearance.shadowColor = .clear
        
        
        navigationController.navigationBar.standardAppearance = appearance
        navigationController.navigationBar.scrollEdgeAppearance = appearance
    }
    
    func start() {
        fatalError("Subclasses must implement start()")
    }
}

