//
//  Car.swift
//  MVVM-R
//
//  Created by Celil Çağatay Gedik on 10.07.2025.
//

import Foundation

struct Car: Identifiable, Codable {
    var id: Int
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
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "tr_TR")
        formatter.maximumFractionDigits = 0
        return formatter.string(from: NSNumber(value: price)) ?? "\(price) TL"
    }
}

extension Car {
    init(listing: Listing) {
        self.id = listing.id
        
        // Extract brand from the category name for better accuracy.
        let categoryParts = listing.category.name.components(separatedBy: "/")
        if categoryParts.count > 1 {
            self.brand = categoryParts[1].capitalized.components(separatedBy: "-").first ?? "Unknown"
        } else {
            self.brand = "Unknown"
        }
        
        self.model = listing.modelName
        
        // Helper function to safely find a property's value from the array.
        func findProperty(name: String) -> String? {
            return listing.properties.first(where: { $0.name == name })?.value
        }
        
        self.year = Int(findProperty(name: "year") ?? "0") ?? 0
        self.price = Double(listing.price)
        // The API photo URL has a placeholder {0}. We replace it to request a specific image size.
        self.imageName = listing.photo.replacingOccurrences(of: "{0}", with: "800x600")
        self.description = listing.title
        self.mileage = Int(findProperty(name: "km") ?? "0") ?? 0
        
        // These properties are not in the API, so we provide default values.
        self.fuelType = "N/A"
        
        // Attempt to parse transmission type from the model name.
        if listing.modelName.lowercased().contains("manuel") {
            self.transmission = "Manual"
        } else if listing.modelName.lowercased().contains("otomatik") || listing.modelName.lowercased().contains("dsg") {
            self.transmission = "Automatic"
        } else {
            self.transmission = "N/A"
        }
    }
}
