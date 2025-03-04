//
//  SignUpCoordinator.swift
//  FitnessX
//
//  Created by Md Sadidur Rahman on 1/3/25.
//

import UIKit

protocol SignUpCoordinatorDelegate: AnyObject {
    func signUpDidComplete()
    func signUpDidRequestLogin()
}

class SignUpCoordinator: FitnessBaseCoordinator {
    weak var delegate: SignUpCoordinatorDelegate?
    
    override func start() {
        let storyboard = UIStoryboard(name: "Signup",
                                      bundle: nil)
        guard let signupVC = storyboard.instantiateViewController(withIdentifier: "SignUpVC") as? SignUpVC else {
            return
        }
        
        // Configure with ViewModel
//        let viewModel = WelcomeViewModel()
//        viewModel.coordinator = self
//        welcomeVC.configure(with: viewModel)
        
        // Push using NavigationManager
        NavigationManager.shared.navigate(to: signupVC,
                                          using: .push(animated: true))
    }
    
    func showLogin() {
        delegate?.signUpDidRequestLogin()
    }
    
    func completeSignUp() {
        delegate?.signUpDidComplete()
    }
}
