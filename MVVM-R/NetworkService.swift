//
//  NetworkService.swift
//  MVVM-R
//
//  Created by Celil Çağatay Gedik on 10.07.2025.
//

import Foundation

final class NetworkService {
    static let shared = NetworkService()
    private init() {}
    
    func login(username: String, password: String) async throws -> User {
        try await Task.sleep(nanoseconds: 1_000_000_000)
        
        if username == "demo" && password == "password" {
            return User(username: username, email: "demo@example.com")
        } else {
            throw NetworkError.invalidCredentials
        }
    }
    
    func fetchCars() async throws -> [Car] {
        try await Task.sleep(nanoseconds: 1_500_000_000)
        
        return [
            Car(brand: "BMW", model: "M3", year: 2023, price: 75000, imageURL: "https://example.com/bmw-m3.jpg", description: "High-performance luxury sedan with exceptional handling and power.", mileage: 15000, fuelType: "Gasoline", transmission: "Manual"),
            Car(brand: "Tesla", model: "Model S", year: 2024, price: 95000, imageURL: "https://example.com/tesla-model-s.jpg", description: "Electric luxury sedan with autopilot and premium interior.", mileage: 8000, fuelType: "Electric", transmission: "Automatic"),
            Car(brand: "Audi", model: "RS6", year: 2023, price: 120000, imageURL: "https://example.com/audi-rs6.jpg", description: "High-performance wagon with quattro all-wheel drive.", mileage: 12000, fuelType: "Gasoline", transmission: "Automatic"),
            Car(brand: "Mercedes", model: "AMG GT", year: 2024, price: 140000, imageURL: "https://example.com/mercedes-amg-gt.jpg", description: "Sports car with handcrafted AMG engine and premium features.", mileage: 5000, fuelType: "Gasoline", transmission: "Manual"),
            Car(brand: "Porsche", model: "911 Turbo", year: 2023, price: 200000, imageURL: "https://example.com/porsche-911.jpg", description: "Iconic sports car with turbocharged engine and precision handling.", mileage: 7500, fuelType: "Gasoline", transmission: "Manual")
        ]
    }
}
