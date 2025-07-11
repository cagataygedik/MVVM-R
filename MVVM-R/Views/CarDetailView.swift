//
//  CarDetailView.swift
//  MVVM-R
//
//  Created by Celil Çağatay Gedik on 11.07.2025.
//

import SwiftUI

struct CarDetailView: View {
    @StateObject var viewModel: CarDetailViewModel
    private let router: Router
    @Environment(\.dismiss) private var dismiss
    
    init(car: Car, router: Router) {
        _viewModel = StateObject(wrappedValue: CarDetailViewModel(car: car))
        self.router = router
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                ZStack {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 250)
                    
                    if let uiImage = UIImage(named: viewModel.car.imageName) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 250)
                            .clipped()
                    } else {
                        Image(systemName: "car.fill")
                            .font(.system(size: 60))
                            .foregroundStyle(.blue)
                    }
                }
                
                VStack(alignment: .leading, spacing: 15) {
                    HStack {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("\(viewModel.car.brand) \(viewModel.car.model)")
                                .font(.title)
                                .fontWeight(.bold)
                            Text("Year: \(viewModel.car.year)")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            viewModel.toggleFavorite()
                        }) {
                            Image(systemName: viewModel.isFavorite ? "heart.fill" : "heart")
                                .font(.title2)
                                .foregroundStyle(viewModel.isFavorite ? .red : .gray)
                        }
                    }
                    Text(viewModel.car.formattedPrice)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(.green)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Specification")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        SpecificationRow(title: "Mileage", value: "\(viewModel.car.mileage)")
                        SpecificationRow(title: "Fuel Type", value: viewModel.car.fuelType)
                        SpecificationRow(title: "Transmission", value: viewModel.car.transmission)
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Description")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        Text(viewModel.car.description)
                            .font(.body)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle("Car Details")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button {
                print("share button tapped")
            } label: {
                Image(systemName: "square.and.arrow.up")
            }
        }
    }
}
