//
//  LoginViewModel.swift
//  MVVM-R
//
//  Created by Celil Çağatay Gedik on 10.07.2025.
//

import Foundation

final class LoginViewModel: BaseHostingViewModel<LoginRouter> {
    @Published var username = ""
    @Published var password = ""
    @Published var isLoading = false
    @Published var errorMessage = ""
    
    private let loginService: LoginServiceProtocol
    
    init(router: LoginRouter, loginService: LoginServiceProtocol = LoginService()) {
        self.loginService = loginService
        super.init(router: router)
    }
    
    @MainActor
    func login() async {
        isLoading = true
        errorMessage = ""
        
        do {
            let _ = try await loginService.login(username: username, password: password)
            router.loginSuccessful()
        } catch {
            errorMessage = "Invalid credentials"
        }
        isLoading = false
    }
}
