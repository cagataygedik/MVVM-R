//
//  AppCoordinator.swift
//  MVVM-R
//
//  Created by Celil Çağatay Gedik on 10.07.2025.
//

import UIKit

final class AppCoordinator: ObservableObject {
    @Published var router = Router()
    
    func start() -> UIViewController {
        return RootViewController(coordinator: self)
    }
}
