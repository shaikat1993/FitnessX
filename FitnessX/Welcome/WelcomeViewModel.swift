//
//  WelcomeViewModel.swift
//  FitnessX
//
//  Created by Md Sadidur Rahman on 1/3/25.
//

import Foundation

class WelcomeViewModel {
    weak var coordinator: WelcomeCoordinator?
    
    func getStartedTapped() {
        coordinator?.showOnboarding()
    }
}
