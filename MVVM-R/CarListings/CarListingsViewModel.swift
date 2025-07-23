//
//  CarListingsViewModel.swift
//  MVVM-R
//
//  Created by Celil Çağatay Gedik on 10.07.2025.
//

import Foundation

final class CarListingsViewModel: BaseViewModel<CarListingsRouter> {
    @Published var cars: [Car] = []
    @Published var isLoading = false
    @Published var errorMessage = ""
    
    private let carService: CarServiceProtocol
    
    init(router: CarListingsRouter, carService: CarServiceProtocol = CarService()) {
        self.carService = carService
        super.init(router: router)
    }
    
    @MainActor
    func fetchCars() async {
        isLoading = true
        errorMessage = ""
        
        do {
            let listings = try await carService.fetchCars(take: 10)
            self.cars = listings.map { Car(listing: $0) }
        } catch {
            errorMessage = "Failed to load cars: \(error.localizedDescription)"
            self.cars = []
        }
        isLoading = false
    }
    
    func selectCar(_ car: Car) {
        router.pushCarDetail(for: car)
    }
}
