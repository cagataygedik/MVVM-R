//
//  CarDetailRouter.swift
//  MVVM-R
//
//  Created by Celil Çağatay Gedik on 10.07.2025.
//

import Foundation

final class CarDetailRouter: RouterProtocol {
    private let router: Router
    
    init(router: Router) {
        self.router = router
    }
    
    func navigate(to route: Route) {
        router.navigate(to: route)
    }
    
    func goBack() {
        
    }
}
