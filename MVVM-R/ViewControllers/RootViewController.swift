//
//  RootViewController.swift
//  MVVM-R
//
//  Created by Celil Çağatay Gedik on 10.07.2025.
//

import UIKit
import SwiftUI
import Combine

final class RootViewController: UIViewController {
    private let coordinator: AppCoordinator
    private var currentViewController: UIViewController?
    private var cancellables = Set<AnyCancellable>()
    
    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        showCurrentRoute()
    }
    
    private func setupBindings() {
        coordinator.router.$currentRoute
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.showCurrentRoute()
            }
            .store(in: &cancellables)
    }
    
    private func showCurrentRoute() {
        let newViewController: UIViewController
        
        switch coordinator.router.currentRoute {
        case .login:
            let loginView = LoginView(router: coordinator.router)
            newViewController = UIHostingController(rootView: loginView)
            
        case .main:
            newViewController = MainTabBarController(router: coordinator.router)
            
        case .carDetail:
            return
        }
        
        if type(of: currentViewController) == type(of: newViewController) {
            return
        }
        
        if let current = currentViewController {
            current.willMove(toParent: nil)
            current.view.removeFromSuperview()
            current.removeFromParent()
        }
        
        addChild(newViewController)
        view.addSubview(newViewController.view)
        newViewController.view.frame = view.bounds
        newViewController.didMove(toParent: self)
        currentViewController = newViewController
    }
}
