//
//  AuthService.swift
//  FitnessX
//
//  Created by Md Sadidur Rahman on 1/3/25.
//

import Foundation

protocol AuthServiceType{
    var isSignedin: Bool { get }
}

final class AuthService: AuthServiceType{
    static let shared = AuthService()
    
    var isSignedin: Bool{
        UserDefaults.standard.string(forKey: "authToken") != nil
    }
}
