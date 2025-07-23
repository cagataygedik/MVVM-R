//
//  BaseNetworkClient.swift
//  MVVM-R
//
//  Created by Celil Çağatay Gedik on 23.07.2025.
//

import Foundation

protocol BaseAPIClientProtocol {
    func request<T: Decodable>(endpoint: Endpoint) async throws -> T
}

open class BaseAPIClient: BaseAPIClientProtocol {
    public init() {}
    
    public func request<T: Decodable>(endpoint: Endpoint) async throws -> T {
        guard var urlComponents = URLComponents(string: endpoint.baseURL + endpoint.path) else {
            throw NetworkError.networkUnavailable
        }
        
        if let parameters = endpoint.parameters {
            urlComponents.queryItems = parameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        }
        
        guard let url = urlComponents.url else {
            throw NetworkError.networkUnavailable
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else  {
                throw NetworkError.networkUnavailable
            }
            let decodedObject = try JSONDecoder().decode(T.self, from: data)
            return decodedObject
        } catch {
            throw error
        }
    }
}
