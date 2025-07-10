//
//  MainTabBarController.swift
//  MVVM-R
//
//  Created by Celil Çağatay Gedik on 10.07.2025.
//

import UIKit

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
        let carListingsViewModel = CarListingsViewModel(router: router)
        let carListingsViewController = CarListingsViewController(viewModel: carListingsViewModel)
        carListingsViewController.tabBarItem = UITabBarItem(title: "Cars", image: UIImage(systemName: "car.fill"), tag: 0)
        
        let favoritesViewController = FavoritesViewController(router: router)
        favoritesViewController.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "heart.fill"), tag: 1)
        
        let carListingsNavigationController = UINavigationController(rootViewController: carListingsViewController)
        let favoritesNavigationController = UINavigationController(rootViewController: favoritesViewController)
        
        carListingsNavigationController.navigationBar.prefersLargeTitles = true
        favoritesNavigationController.navigationBar.prefersLargeTitles = true
        
        viewControllers = [carListingsNavigationController, favoritesNavigationController]
    }
}
