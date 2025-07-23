//
//  Endpoint.swift
//  MVVM-R
//
//  Created by Celil Çağatay Gedik on 23.07.2025.
//

import Foundation

public typealias Parameters = [String: Any]

public protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: Parameters? { get }
}

extension Endpoint {
    public var baseURL: String {
        return "https://sandbox.arabamd.com/api/v1"
    }
    
    public var parameters: Parameters? {
        return nil
    }
}
