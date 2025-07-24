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
    }
    
    private func setupTabs() {
        let carListingsRouter = CarListingsRouter(appRouter: router)
        let carListingsViewModel = CarListingsViewModel(router: carListingsRouter)
        let carListingsViewController = CarListingsViewController(viewModel: carListingsViewModel)
        carListingsViewController.tabBarItem = UITabBarItem(title: "Cars", image: UIImage(systemName: "car.fill"), tag: 0)
        
        let carListingsNavigationController = UINavigationController(rootViewController: carListingsViewController)
        carListingsNavigationController.navigationBar.prefersLargeTitles = true
        
        let carListingsViewModelSwiftUI = CarListingsViewModel(router: carListingsRouter)
        let carListingsSwiftUIView = CarListingsSwiftUIView(viewModel: carListingsViewModelSwiftUI)
        let carListingsSwiftUIViewController = BaseHostingViewController(rootView: carListingsSwiftUIView, viewModel: carListingsViewModelSwiftUI)
        carListingsSwiftUIViewController.tabBarItem = UITabBarItem(title: "Cars (SwiftUI)", image: UIImage(systemName: "car"), tag: 1)
        carListingsSwiftUIViewController.title = "Car Listings (SwiftUI)"
        
        let carListingsSwiftUINavigationController = UINavigationController(rootViewController: carListingsSwiftUIViewController)
        carListingsSwiftUINavigationController.navigationBar.prefersLargeTitles = true
        
        let favoritesRouter = FavoritesRouter(appRouter: router)
        let favoritesViewModel = FavoritesViewModel(router: favoritesRouter)
        let favoritesViewController = FavoritesViewController(viewModel: favoritesViewModel)
        favoritesViewController.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "heart.fill"), tag: 2)
        
        let favoritesNavigationController = UINavigationController(rootViewController: favoritesViewController)
        favoritesNavigationController.navigationBar.prefersLargeTitles = true
        
        let settingsRouter = SettingsRouter(appRouter: router)
        let settingsViewModel = SettingsViewModel(router: settingsRouter)
        let settingsViewController = SettingsViewController(viewModel: settingsViewModel)
        settingsViewController.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 3)
        
        let settingsNavigationController = UINavigationController(rootViewController: settingsViewController)
        settingsNavigationController.navigationBar.prefersLargeTitles = true
        
        viewControllers = [carListingsNavigationController, carListingsSwiftUINavigationController, favoritesNavigationController, settingsNavigationController]
    }
    
    @objc func shareTapped() {
        print("share tapped")
    }
}
