//
//  FavoritesViewModel.swift
//  MVVM-R
//
//  Created by Celil Çağatay Gedik on 11.07.2025.
//

import Foundation
import Combine

final class FavoritesViewModel: BaseViewModel<FavoritesRouter> {
    @Published var favoriteCars: [Car] = []
    
    private let favoritesManager = FavoritesManager.shared
    
    override init(router: FavoritesRouter) {
        super.init(router: router)
        setupBindings()
    }
    
    private func setupBindings() {
        favoritesManager.$favorites
            .assign(to: \.favoriteCars, on: self)
            .store(in: &cancellables)
    }
    
    func selectCar(_ car: Car) {
        router.pushCarDetail(for: car)
    }
}
