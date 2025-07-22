//
//  CarDetailViewModel.swift
//  MVVM-R
//
//  Created by Celil Çağatay Gedik on 11.07.2025.
//

import Foundation

class CarDetailViewModel: BaseHostingViewModel<CarDetailRouter> {
    @Published var car: Car
    @Published var isFavorite: Bool = false
    
    private let favoritesManager = FavoritesManager.shared
    
    init(car: Car, router: CarDetailRouter) {
        self.car = car
        super.init(router: router)
        self.isFavorite = favoritesManager.isFavorite(car)
    }
    
    func toggleFavorite() {
        favoritesManager.toggleFavorite(car)
        isFavorite = favoritesManager.isFavorite(car)
    }
}
