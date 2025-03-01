//
//  OnboardingViewModel.swift
//  FitnessX
//
//  Created by Md Sadidur Rahman on 28/2/25.
//

import Foundation

class OnboardingViewModel {
    weak var coordinator: OnboardingCoordinator?
    
    @Published private(set) var currentPage = 0
    private(set) var slides = OnboardingSlideModel.slides
    
    func nextSlide() {
        updateSlides(currentPage + 1)
    }
    
    func updateSlides(_ page: Int) {
        guard page >= 0 
                && page < slides.count else { return }
        currentPage = page
    }
    
    func onboardingCompleted(){
        UserDefaults.standard.set(true,
                                  forKey: "hasOnboarded")
        coordinator?.onboardingDidCompleted()
    }  
}
