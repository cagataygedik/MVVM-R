//
//  CarTableViewCell.swift
//  MVVM-R
//
//  Created by Celil Çağatay Gedik on 10.07.2025.
//

import UIKit
import SnapKit

final class CarTableViewCell: UITableViewCell {
    static let identifier = "CarTableViewCell"

    private let containerView = UIView()
    private let brandLabel = UILabel()
    private let modelLabel = UILabel()
    private let yearLabel = UILabel()
    private let priceLabel = UILabel()
    private let mileageLabel = UILabel()
    private let carImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        contentView.addSubview(containerView)
        containerView.addSubview(carImageView)
        containerView.addSubview(brandLabel)
        containerView.addSubview(modelLabel)
        containerView.addSubview(yearLabel)
        containerView.addSubview(priceLabel)
        containerView.addSubview(mileageLabel)
        
        containerView.backgroundColor = .systemBackground
        containerView.layer.cornerRadius = 12
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerView.layer.shadowRadius = 4
        containerView.layer.shadowOpacity = 0.1
        
        carImageView.backgroundColor = .systemGray5
        carImageView.contentMode = .scaleAspectFill
        carImageView.clipsToBounds = true
        carImageView.layer.cornerRadius = 8
        carImageView.image = UIImage(systemName: "car.fill")
        carImageView.tintColor = .systemBlue
        
        brandLabel.font = .systemFont(ofSize: 18, weight: .bold)
        brandLabel.textColor = .label
        
        modelLabel.font = .systemFont(ofSize: 16, weight: .medium)
        modelLabel.textColor = .secondaryLabel
        
        yearLabel.font = .systemFont(ofSize: 14, weight: .medium)
        yearLabel.textColor = .tertiaryLabel
        
        priceLabel.font = .systemFont(ofSize: 16, weight: .bold)
        priceLabel.textColor = .systemGreen
        
        mileageLabel.font = .systemFont(ofSize: 14, weight: .regular)
        mileageLabel.textColor = .secondaryLabel
        
        containerView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        carImageView.snp.makeConstraints { make in
            // 👇 This is the change
            make.leading.equalToSuperview().inset(16)
            make.centerY.equalToSuperview() // Center vertically instead of top/bottom constraints
            make.width.height.equalTo(80) // Keep the size fixed
        }
        
        brandLabel.snp.makeConstraints { make in
            make.leading.equalTo(carImageView.snp.trailing).offset(16)
            make.top.equalToSuperview().inset(16)
            make.trailing.lessThanOrEqualTo(priceLabel.snp.leading).offset(-8)
        }
        
        modelLabel.snp.makeConstraints { make in
            make.leading.equalTo(brandLabel)
            make.top.equalTo(brandLabel.snp.bottom).offset(4)
            make.trailing.lessThanOrEqualTo(priceLabel.snp.leading).offset(-8)
        }
        
        yearLabel.snp.makeConstraints { make in
            make.leading.equalTo(brandLabel)
            make.top.equalTo(modelLabel.snp.bottom).offset(4)
            make.trailing.lessThanOrEqualTo(priceLabel.snp.leading).offset(-8)
        }
        
        mileageLabel.snp.makeConstraints { make in
            make.leading.equalTo(brandLabel)
            make.top.equalTo(yearLabel.snp.bottom).offset(4)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
    }
    
    func configure(with car: Car) {
        brandLabel.text = car.brand
        modelLabel.text = car.model
        yearLabel.text = String(car.year)
        priceLabel.text = car.formattedPrice
        mileageLabel.text = "\(car.mileage) miles"
        
        if let image = UIImage(named: car.imageName) {
            carImageView.image = image
            carImageView.backgroundColor = .clear
        } else {
            
            carImageView.image = UIImage(systemName: "car.fill")
            carImageView.tintColor = .systemBlue
            carImageView.backgroundColor = .systemGray5
        }
    }
}
