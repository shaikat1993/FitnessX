//
//  Routes.swift
//  FitnessX
//
//  Created by Md Sadidur Rahman on 27/2/25.
//

import Foundation

enum FitnessXRoute{
    //onboarding
    case onboarding
    case welcome
    //case registration(RegistrationData)
    
    //Main App Flow
    case home
    //case workout(workoutType)
    //case nutrition(MealPlan)
    case profile
    case settings
    
    // Workout Flow
    //case workoutDetail(Workout)
    //case exerciseGuide(Exercise)
    //case workoutProgress(WorkoutSession)
    
    // Nutrition Flow
    case mealPlanner
    case nutritionTracker
    case waterIntake
}
