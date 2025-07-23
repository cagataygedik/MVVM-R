//
//  LoginService.swift
//  MVVM-R
//
//  Created by Celil Çağatay Gedik on 23.07.2025.
//

import Foundation

protocol LoginServiceProtocol {
    func login(username: String, password: String) async throws -> User
}

final class LoginService: BaseAPIClient, LoginServiceProtocol {
    func login(username: String, password: String) async throws -> User {
        try await Task.sleep(nanoseconds: 1_000_000_000)
        
        if username == "demo" && password == "password" {
            return User(username: username, email: "demo@example.com")
        } else {
            throw NetworkError.invalidCredentials
        }
    }
}
