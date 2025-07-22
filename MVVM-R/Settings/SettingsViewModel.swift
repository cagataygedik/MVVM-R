//
//  SettingsViewModel.swift
//  MVVM-R
//
//  Created by Celil Çağatay Gedik on 10.07.2025.
//

import Foundation

final class SettingsViewModel: BaseViewModel<SettingsRouter> {
    func logout() {
        router.logout()
    }
} 
