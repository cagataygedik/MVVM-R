//
//  SettingsViewModel.swift
//  MVVM-R
//
//  Created by Celil Çağatay Gedik on 10.07.2025.
//

import Foundation

final class SettingsViewModel: ObservableObject {
    private let router: Router
    
    init(router: Router) {
        self.router = router
    }
    
    func logout() {
        router.logout()
    }
} 