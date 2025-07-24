//
//  CarRowView.swift
//  MVVM-R
//
//  Created by Celil Çağatay Gedik on 24.07.2025.
//

import SwiftUI
import Kingfisher

struct CarRowView: View {
    let car: Car
    
    var body: some View {
        HStack(spacing: 16) {
            KFImage(URL(string: car.imageName))
                .placeholder {
                    Image(systemName: "car.fill")
                        .foregroundStyle(.blue)
                        .frame(width: 80, height: 80)
                        .background(Color(.systemGray5))
                }
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(car.model)
                    .font(.system(size: 18, weight: .bold))
                    .lineLimit(2)
                Text(car.brand)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(.secondary)
                Text(String(car.year))
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(.tertiary)
                Text("\(car.mileage) km")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            Text(car.formattedPrice)
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(.green)
        }
        .padding(.horizontal)
    }
}

