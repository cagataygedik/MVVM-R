//
//  BaseNetworkClient.swift
//  MVVM-R
//
//  Created by Celil Çağatay Gedik on 23.07.2025.
//

import Foundation
import Alamofire

open class BaseAPIClient {
    public init() {}
    
    public func request<T: Decodable>(endpoint: Endpoint) async throws -> T {
        let url = endpoint.baseURL + endpoint.path
        
        let dataTask = AF.request(url, method: endpoint.method, parameters: endpoint.parameters, headers: endpoint.headers)
            .validate()
            .serializingDecodable(T.self)
        
        let result = await dataTask.result
        
        switch result {
        case .success(let value):
            return value
        case .failure(let error):
            throw error
        }
    }
}
