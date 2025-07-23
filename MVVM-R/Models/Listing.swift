//
//  Listing.swift
//  MVVM-R
//
//  Created by Celil Çağatay Gedik on 23.07.2025.
//

import Foundation

struct Listing: Codable, Identifiable {
    let id: Int
    let title: String
    let location: Location
    let category: Category
    let modelName: String
    let price: Int
    let priceFormatted: String
    let date: String
    let dateFormatted: String
    let photo: String
    let properties: [Property]
}

struct Category: Codable {
    let id: Int
    let name: String
}

struct Location: Codable {
    let cityName: String
    let townName: String
}

struct Property: Codable {
    let name: String
    let value: String?
}
