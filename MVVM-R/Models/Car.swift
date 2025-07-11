//
//  Car.swift
//  MVVM-R
//
//  Created by Celil Çağatay Gedik on 10.07.2025.
//

import Foundation

struct Car: Identifiable, Codable {
    var id = UUID()
    let brand: String
    let model: String
    let year: Int
    let price: Double
    let imageName: String
    let description: String
    let mileage: Int
    let fuelType: String
    let transmission: String
    
    var formattedPrice: String {
        return String(format: "$%.0f", price)
    }
}
