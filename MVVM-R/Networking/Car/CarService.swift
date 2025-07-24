//
//  CarService.swift
//  MVVM-R
//
//  Created by Celil Çağatay Gedik on 23.07.2025.
//

import Foundation
import NetworkKit

protocol CarServiceProtocol {
    func fetchCars(skip: Int, take: Int) async throws -> [Listing]
}

final class CarService: BaseAPIClient, CarServiceProtocol {
    func fetchCars(skip: Int, take: Int = 10) async throws -> [Listing] {
        let endpoint = CarEndpoint.getListings(skip: skip, take: take)
        return try await request(endpoint: endpoint)
    }
}

