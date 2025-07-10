//
//  LoginViewModel.swift
//  MVVM-R
//
//  Created by Celil Çağatay Gedik on 10.07.2025.
//

import Foundation

final class LoginViewModel: ObservableObject {
    @Published var username = ""
    @Published var password = ""
    @Published var isLoading = false
    @Published var errorMessage = ""
    
    private let networkService = NetworkService.shared
    private let router: Router
    
    init(router: Router) {
        self.router = router
    }
    
    @MainActor
    func login() async {
        isLoading = true
        errorMessage = ""
        
        do {
            let user = try await networkService.login(username: username, password: password)
            router.login()
        } catch {
            errorMessage = "Invalid credentials"
        }
        isLoading = false
    }
}
