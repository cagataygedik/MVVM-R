//
//  SettingsViewModel.swift
//  MVVM-R
//
//  Created by Celil Çağatay Gedik on 10.07.2025.
//

import Foundation

final class SettingsViewModel: ObservableObject {
    private let router: SettingsRouter
    
    init(router: SettingsRouter) {
        self.router = router
    }
    
    func logout() {
        router.logout()
    }
} 