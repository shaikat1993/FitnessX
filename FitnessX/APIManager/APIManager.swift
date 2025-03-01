//
//  APIManager.swift
//  FitnessX
//
//  Created by Md Sadidur Rahman on 7/1/25.
//

import Foundation
final class APIManager {
    private let networkManager: NetworkManager
    private let baseURL: String
    
    init(baseURL: String = "https://api.example.com") {
        self.networkManager = .shared
        self.baseURL = baseURL
    }
    
    // MARK: - Endpoint Enum
    enum Endpoint {
        case login
        case register
        case profile
        case updateProfile
        case workouts
        case workout(id: String)
        
        var path: String {
            switch self {
            case .login:
                return "/auth/login"
            case .register:
                return "/auth/register"
            case .profile:
                return "/profile"
            case .updateProfile:
                return "/profile/update"
            case .workouts:
                return "/workouts"
            case .workout(let id):
                return "/workouts/\(id)"
            }
        }
    }
    
    private func makeURL(_ endpoint: Endpoint) -> String {
        return baseURL + endpoint.path
    }
}

// MARK: - API Manager Auth Methods
extension APIManager {
//    func login(email: String, password: String, completion: @escaping (Result<User, NetworkError>) -> Void) {
//        let loginBody = LoginRequest(email: email, password: password)
//        
//        networkManager.request(
//            User.self,
//            url: makeURL(.login),
//            method: .post,
//            body: loginBody,
//            headers: ["Content-Type": "application/json"]
//        ) { result in
//            completion(result)
//        }
//    }
}

