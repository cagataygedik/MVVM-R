//
//  SettingsView.swift
//  MVVM-R
//
//  Created by Celil Çağatay Gedik on 10.07.2025.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var viewModel: SettingsViewModel
    
    var body: some View {
            List {
                Section(header: Text("Account")) {
                    Button(action: {
                        viewModel.logout()
                    }) {
                        HStack {
                            Text("Logout")
                                .foregroundColor(.red)
                            Spacer()
                            Image(systemName: "arrow.right.circle")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
    }
} 
