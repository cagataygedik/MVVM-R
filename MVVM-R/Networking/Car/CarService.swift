//
//  CarService.swift
//  MVVM-R
//
//  Created by Celil Çağatay Gedik on 23.07.2025.
//

import Foundation

protocol CarServiceProtocol {
    func fetchCars(take: Int) async throws -> [Listing]
}

final class CarService: BaseAPIClient, CarServiceProtocol {
    func fetchCars(take: Int = 10) async throws -> [Listing] {
        let endpoint = CarEndpoint.getListings(take: take)
        return try await request(endpoint: endpoint)
    }
}

