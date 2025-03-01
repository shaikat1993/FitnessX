import Foundation
import Network

// MARK: - Network Error
enum NetworkError: Error {
    case noNetwork
    case invalidURL
    case invalidResponse
    case serverError(Int)
    case decodingError
    case unknown(Error)
    
    var message: String {
        switch self {
        case .noNetwork: return "No internet connection"
        case .invalidURL: return "Invalid URL"
        case .invalidResponse: return "Invalid response"
        case .serverError(let code): return "Server error: \(code)"
        case .decodingError: return "Failed to decode response"
        case .unknown(let error): return error.localizedDescription
        }
    }
}

// MARK: - Network Manager
final class NetworkManager {
    static let shared = NetworkManager()
    private var session: URLSession
    private let monitor: NWPathMonitor
    private let queue = DispatchQueue(label: "NetworkMonitor")
    private var isReachable: Bool = true
    
    private init() {
        // Setup URLSession
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30
        config.waitsForConnectivity = true
        self.session = URLSession(configuration: config)
        
        // Setup Network Monitor
        monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isReachable = path.status == .satisfied
        }
        monitor.start(queue: queue)
    }
    
    deinit {
        monitor.cancel()
    }
    
    // MARK: - GET
    func get<T: Decodable>(
        from url: String,
        headers: [String: String]? = nil,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        executeRequest(url: url, method: "GET", headers: headers, completion: completion)
    }
    
    // MARK: - POST
    func post<T: Decodable>(
        to url: String,
        body: Encodable,
        headers: [String: String]? = nil,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        guard let jsonData = try? JSONEncoder().encode(body) else {
            completion(.failure(.decodingError))
            return
        }
        executeRequest(url: url, method: "POST", body: jsonData, headers: headers, completion: completion)
    }
    
    // MARK: - PUT
    func put<T: Decodable>(
        to url: String,
        body: Encodable,
        headers: [String: String]? = nil,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        guard let jsonData = try? JSONEncoder().encode(body) else {
            completion(.failure(.decodingError))
            return
        }
        executeRequest(url: url, method: "PUT", body: jsonData, headers: headers, completion: completion)
    }
    
    // MARK: - DELETE
    func delete<T: Decodable>(
        from url: String,
        headers: [String: String]? = nil,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        executeRequest(url: url, method: "DELETE", headers: headers, completion: completion)
    }
    
    // MARK: - Core Request Method
    private func executeRequest<T: Decodable>(
        url urlString: String,
        method: String,
        body: Data? = nil,
        headers: [String: String]? = nil,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        // Check network availability
        guard isReachable else {
            DispatchQueue.main.async {
                completion(.failure(.noNetwork))
            }
            return
        }
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.httpBody = body
        
        // Default headers
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        // Custom headers
        headers?.forEach { request.setValue($0.value, forHTTPHeaderField: $0.key) }
        
        session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(.unknown(error)))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(.failure(.invalidResponse))
                    return
                }
                
                guard (200...299).contains(httpResponse.statusCode) else {
                    completion(.failure(.serverError(httpResponse.statusCode)))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(.invalidResponse))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let result = try decoder.decode(T.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(.decodingError))
                }
            }
        }.resume()
    }
}
