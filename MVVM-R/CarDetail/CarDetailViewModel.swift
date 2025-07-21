//
//  CarDetailViewModel.swift
//  MVVM-R
//
//  Created by Celil Çağatay Gedik on 11.07.2025.
//

import Foundation

class CarDetailViewModel: ObservableObject {
    @Published var car: Car
    @Published var isFavorite: Bool = false
    
    private let favoritesManager = FavoritesManager.shared
    
    init(car: Car) {
        self.car = car
        self.isFavorite = favoritesManager.isFavorite(car)
    }
    
    func toggleFavorite() {
        favoritesManager.toggleFavorite(car)
        isFavorite = favoritesManager.isFavorite(car)
    }
}
