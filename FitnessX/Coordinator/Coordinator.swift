//
//  Coordinator.swift
//  FitnessX
//
//  Created by Md Sadidur Rahman on 27/2/25.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get }
    var childCoordinators: [String: Coordinator] { get set }
    var parentCoordinator: Coordinator? { get set }
    
    func start()
    func finish()
}

extension Coordinator {
    func addChild(_ coordinator: Coordinator,
                  with identifier: String) {
        childCoordinators[identifier] = coordinator
        coordinator.parentCoordinator = self
    }
    
    func removeChild(_ identifier: String) {
        childCoordinators.removeValue(forKey: identifier)
    }
    
    func finish() {
        childCoordinators.removeAll()
    }
}
