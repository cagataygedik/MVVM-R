//
//  CarDetailRoute.swift
//  MVVM-R
//
//  Created by Celil Çağatay Gedik on 22.07.2025.
//

import UIKit
import SwiftUI

protocol CarDetailRoute {
    func pushCarDetail(for car: Car)
}

extension CarDetailRoute where Self: BaseRouter {
    
    func pushCarDetail(for car: Car) {
        let router = CarDetailRouter(appRouter: appRouter)
        let viewModel = CarDetailViewModel(car: car, router: router)
        let contentView = CarDetailView(viewModel: viewModel)
        
        let hostingController = BaseHostingViewController(rootView: contentView, viewModel: viewModel)
        hostingController.navigationItem.title = "Car Details"
        hostingController.navigationItem.largeTitleDisplayMode = .never
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first(where: { $0.isKeyWindow }),
              let mainTabBarController = window.rootViewController?.children.first as? MainTabBarController,
              let navController = mainTabBarController.selectedViewController as? UINavigationController else {
            print("Error: Could not find the main navigation controller.")
            return
        }
        
        let shareButton = UIBarButtonItem(
            image: UIImage(systemName: "square.and.arrow.up"),
            style: .plain,
            target: mainTabBarController,
            action: #selector(mainTabBarController.shareTapped)
        )
        hostingController.navigationItem.rightBarButtonItem = shareButton
        
        navController.pushViewController(hostingController, animated: true)
    }
}
