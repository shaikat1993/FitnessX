//
//  OnboardingSlideModel.swift
//  FitnessX
//
//  Created by Md Sadidur Rahman on 5/1/25.
//

import UIKit

struct OnboardingSlideModel{
    let title : String?
    let description: String?
    let image: UIImage?
   // let index: Int?  // to track slide position
}

// MARK: - Onboarding Data
extension OnboardingSlideModel {
    static let slides: [OnboardingSlideModel] = [
        OnboardingSlideModel(
            title: "Track Your Goal",
            description: "Don't worry if you have trouble determining your goals, we can help you determine your goals and track your goals",
            image: UIImage(named: "track_goals")!
        ),
        OnboardingSlideModel(
            title: "Get Burn",
            description: "Let's keep burning, to achieve yours goals, it hurts only temporarily, if you give up now you will be in pain forever",
            image: UIImage(named: "get_burn")!
            
        ),
        OnboardingSlideModel(
            title: "Eat Well",
            description: "Let's start a healthy lifestyle with us, we can determine your diet every day. healthy eating is fun",
            image: UIImage(named: "eat_well")!
            
        ),
        OnboardingSlideModel(
            title: "Improve Sleep Quality",
            description: "Improve the quality of your sleep with us, good quality sleep can bring a good mood in the morning",
            image: UIImage(named: "improve_sleep")!
        )
    ]
}
