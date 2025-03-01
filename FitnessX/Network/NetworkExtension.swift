//
//  NetworkExtension.swift
//  FitnessX
//
//  Created by Md Sadidur Rahman on 7/1/25.
//

import Foundation
// MARK: - HTTP Methods Enum
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

// MARK: - NetworkManager Extension
extension NetworkManager {
    /// Performs a network request with type-safe response
    func request<T: Decodable>(
        _ type: T.Type,
        url: String,
        method: HTTPMethod = .get,
        body: Encodable? = nil,
        headers: [String: String]? = nil,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        switch method {
        case .get:
            get(from: url, headers: headers, completion: completion)
            
        case .post:
            guard let body = body else {
                completion(.failure(.invalidURL))
                return
            }
            post(to: url, body: body, headers: headers, completion: completion)
            
        case .put:
            guard let body = body else {
                completion(.failure(.invalidURL))
                return
            }
            put(to: url, body: body, headers: headers, completion: completion)
            
        case .delete:
            delete(from: url, headers: headers, completion: completion)
        }
    }
}
