//
//  Endpoint.swift
//  MVVM-R
//
//  Created by Celil Çağatay Gedik on 23.07.2025.
//

import Foundation
import Alamofire

public protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: Parameters? { get }
    var headers: HTTPHeaders? { get }
}

extension Endpoint {
    var baseURL: String {
        return "https://sandbox.arabamd.com/api/v1"
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    var parameters: Parameters? {
        return nil
    }
}
