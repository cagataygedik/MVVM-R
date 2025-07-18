//
//  FavoritesViewModel.swift
//  MVVM-R
//
//  Created by Celil Çağatay Gedik on 11.07.2025.
//

import Foundation
import Combine

final class FavoritesViewModel: ObservableObject {
    @Published var favoriteCars: [Car] = []
    
    private let favoritesManager = FavoritesManager.shared
    private let router: Router
    private var cancellables = Set<AnyCancellable>()
    
    init(router: Router) {
        self.router = router
        setupBindings()
    }
    
    private func setupBindings() {
        favoritesManager.$favorites
            .assign(to: \.favoriteCars, on: self)
            .store(in: &cancellables)
    }
    
    func selectCar(_ car: Car) {
        router.navigate(to: .carDetail(car))
    }
}
