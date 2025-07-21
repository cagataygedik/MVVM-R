//
//  CarListingsViewModel.swift
//  MVVM-R
//
//  Created by Celil Çağatay Gedik on 10.07.2025.
//

import Foundation

final class CarListingsViewModel: ObservableObject {
    @Published var cars: [Car] = []
    @Published var isLoading = false
    @Published var errorMessage = ""
    
    private let networkService = NetworkService.shared
    let router: CarListingsRouter
    
    init(router: CarListingsRouter) {
        self.router = router
    }
    
    @MainActor
    func fetchCars() async {
        isLoading = true
        errorMessage = ""
        
        do {
            cars = try await networkService.fetchCars()
        } catch {
            errorMessage = "Failed to load cars"
        }
        isLoading = false
    }
    
    func selectCar(_ car: Car) {
        router.showCarDetail(car: car)
    }
}
