//
//  OnboardingCoordinator.swift
//  FitnessX
//
//  Created by Md Sadidur Rahman on 28/2/25.
//

import UIKit

protocol OnboardingCoordinatorDelegate: AnyObject {
    func onboardingDidComplete()
}

final class OnboardingCoordinator: FitnessBaseCoordinator {
    weak var delegate: OnboardingCoordinatorDelegate?
    
    override func start() {
        let storyboard = UIStoryboard(name: "Onboarding",
                                      bundle: nil)
        guard let onboardingVC = storyboard.instantiateViewController(identifier: "OnboardingVC") as? OnboardingVC else {
            return
        }
        let viewModel = OnboardingViewModel()
        viewModel.coordinator = self
        onboardingVC.configure(with: viewModel)
        navigationController.setViewControllers([onboardingVC],
                                                animated: true)
    }
    
    func onboardingDidCompleted() {
        delegate?.onboardingDidComplete()
    }
}
 
