//
//  LoginRouter.swift
//  MVVM-R
//
//  Created by Celil Çağatay Gedik on 10.07.2025.
//

import Foundation

final class LoginRouter: BaseRouter {
    func loginSuccessful() {
        appRouter.login()
    }
}
