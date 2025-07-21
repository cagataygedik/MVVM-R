//
//  Router.swift
//  MVVM-R
//
//  Created by Celil Çağatay Gedik on 10.07.2025.
//

import Foundation

final class Router: ObservableObject, RouterProtocol {
    @Published var currentRoute: Route = .login
    @Published var isAuthenticated = false
    
    func navigate(to route: Route) {
        currentRoute = route
    }
    
    func login() {
        isAuthenticated = true
        currentRoute = .main
    }
    
    func logout() {
        isAuthenticated = false
        currentRoute = .login
    }
}
