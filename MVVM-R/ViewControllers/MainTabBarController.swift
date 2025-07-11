//
//  MainTabBarController.swift
//  MVVM-R
//
//  Created by Celil Çağatay Gedik on 10.07.2025.
//

import UIKit
import Combine
import SwiftUI

final class MainTabBarController: UITabBarController {
    private let router: Router
    private var cancellables = Set<AnyCancellable>()
    
    init(router: Router) {
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        setupBindings()
    }
    
    private func setupTabs() {
        let carListingsViewModel = CarListingsViewModel(router: router)
        let carListingsViewController = CarListingsViewController(viewModel: carListingsViewModel)
        carListingsViewController.tabBarItem = UITabBarItem(title: "Cars", image: UIImage(systemName: "car.fill"), tag: 0)
        
        let favoritesViewModel = FavoritesViewModel(router: router)
        let favoritesViewController = FavoritesViewController(viewModel: favoritesViewModel)
        favoritesViewController.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "heart.fill"), tag: 1)
        
        let carListingsNavigationController = UINavigationController(rootViewController: carListingsViewController)
        let favoritesNavigationController = UINavigationController(rootViewController: favoritesViewController)
        
        carListingsNavigationController.navigationBar.prefersLargeTitles = true
        favoritesNavigationController.navigationBar.prefersLargeTitles = true
        
        viewControllers = [carListingsNavigationController, favoritesNavigationController]
    }
    
    private func setupBindings() {
        router.$currentRoute
            .receive(on: DispatchQueue.main)
            .sink { [weak self] route in
                guard let self = self else { return }
                if case .carDetail(let car ) = route {
                    self.showCarDetail(car)
                }
            }
            .store(in: &cancellables)
    }
    
    private func showCarDetail(_ car: Car) {
        guard let navController = selectedViewController as? UINavigationController else { return }
        
        if navController.viewControllers.contains(where: {
            if let vc = $0 as? UIHostingController<CarDetailView> {
                return vc.rootView.viewModel.car.id == car.id
            }
            return false
        }) {
            return
        }
        
        let carDetailView = CarDetailView(car: car, router: router)
        let hostingController = UIHostingController(rootView: carDetailView)
        
        hostingController.navigationItem.title = "Car Details"
        hostingController.navigationItem.largeTitleDisplayMode = .never
        
        let shareButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(shareTapped))
        hostingController.navigationItem.rightBarButtonItem = shareButton
        
        navController.pushViewController(hostingController, animated: true)
    }
    
    @objc private func shareTapped() {
        print("share button tapped")
    }
}
