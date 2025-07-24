//
//  CarListingsViewModel.swift
//  MVVM-R
//
//  Created by Celil Çağatay Gedik on 10.07.2025.
//

import Foundation

@MainActor
final class CarListingsViewModel: BaseHostingViewModel<CarListingsRouter>, BaseViewModelProtocol {
    @Published var cars: [Car] = []
    @Published var isLoading = false
    @Published var errorMessage = ""
    @Published var canLoadmorePages = true
    
    private let carService: CarServiceProtocol
    
    private var currentPage = 0
    private let pageSize = 10
    
    init(router: CarListingsRouter, carService: CarServiceProtocol = CarService()) {
        self.carService = carService
        super.init(router: router)
    }
    
    func loadMoreCars() async {
        guard !isLoading else { return }
        
        isLoading = true
        
        do {
            let listings = try await carService.fetchCars(skip: currentPage * pageSize, take: pageSize)
            
            if listings.count < pageSize {
                canLoadmorePages = true
            }
            let newCars = listings.map { Car(listing: $0) }
            cars.append(contentsOf: newCars)
            currentPage += 1
        } catch {
            errorMessage = "failed to load cars: \(error.localizedDescription)"
        }
        isLoading = false
    }
    
    func refresh() async {
        canLoadmorePages = true
        currentPage = 0
        cars = []
        await loadMoreCars()
    }
    
    func selectCar(_ car: Car) {
        router.pushCarDetail(for: car)
    }
}
