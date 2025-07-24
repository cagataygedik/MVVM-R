//
//  CarEndpoint.swift
//  MVVM-R
//
//  Created by Celil Çağatay Gedik on 23.07.2025.
//

import Foundation

enum CarEndpoint: Endpoint {
    case getListings(skip: Int, take: Int)
    
    var path: String {
        switch self {
        case .getListings:
            return "/listing"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getListings:
            return .get
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .getListings(let skip, let take):
            return ["sort": 1, "sortDirection": 0, "skip": skip, "take": take]
        }
    }
}
