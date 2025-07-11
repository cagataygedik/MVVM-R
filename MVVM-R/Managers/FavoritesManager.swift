//
//  FavoritesManager.swift
//  MVVM-R
//
//  Created by Celil Çağatay Gedik on 11.07.2025.
//

import Foundation

final class FavoritesManager: ObservableObject {
    static let shared = FavoritesManager()
    @Published var favorites: [Car] = []
    
    private init() {}
    
    func addToFavorites(_ car: Car) {
        if !favorites.contains(where: { $0.id == car.id }) {
            favorites.append(car)
        }
    }
    
    func removeFromFavorites(_ car: Car) {
        favorites.removeAll { $0.id == car.id }
    }
    
    func isFavorite(_ car: Car) -> Bool {
        return favorites.contains { $0.id == car.id }
    }
    
    func toggleFavorite(_ car: Car) {
        if isFavorite(car) {
            removeFromFavorites(car)
        } else {
            addToFavorites(car)
        }
    }
}
