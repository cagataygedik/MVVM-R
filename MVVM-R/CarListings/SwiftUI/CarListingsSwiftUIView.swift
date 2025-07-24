//
//  CarListingsSwiftUIView.swift
//  MVVM-R
//
//  Created by Celil Çağatay Gedik on 24.07.2025.
//

import SwiftUI

struct CarListingsSwiftUIView: View {
    @ObservedObject var viewModel: CarListingsViewModel //StateObject ??
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.cars) { car in
                    CarRowView(car: car)
                        .padding(.vertical, 4)
                        .onTapGesture {
                            viewModel.selectCar(car)
                        }
                        .task { //.task id
                            if car.id == viewModel.cars.last?.id && viewModel.canLoadmorePages {
                                await viewModel.loadMoreCars()
                            }
                        }
                }
                if viewModel.isLoading {
                    ProgressView()
                        .padding()
                }
            }
        }
        .task {
            if viewModel.cars.isEmpty {
                await viewModel.loadMoreCars()
            }
        }
    }
}
