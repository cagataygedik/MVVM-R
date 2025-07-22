//
//  BaseRouter.swift
//  MVVM-R
//
//  Created by Celil Çağatay Gedik on 22.07.2025.
//

import Foundation

protocol BaseRouterProtocol {
    func navigate(to route: Route)
}

class BaseRouter: BaseRouterProtocol {
    internal let appRouter: Router
    
    init(appRouter: Router) {
        self.appRouter = appRouter
    }
    
    func navigate(to route: Route) {
        appRouter.navigate(to: route)
    }
}
