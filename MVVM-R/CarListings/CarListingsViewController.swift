//
//  CarListingsViewController.swift
//  MVVM-R
//
//  Created by Celil Çağatay Gedik on 10.07.2025.
//

import UIKit
import Combine
import SwiftUI

final class CarListingsViewController: BaseViewController<CarListingsViewModel> {
    private let tableView = UITableView()
    private let refreshControl = UIRefreshControl()
    private let footerSpinner = UIActivityIndicatorView(style: .medium)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupBindings()
        Task {
            await viewModel.loadMoreCars()
        }
    }
    
    private func setupLayout() {
        view.backgroundColor = .systemBackground
        title = "Car Listings"
        
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CarTableViewCell.self, forCellReuseIdentifier: CarTableViewCell.identifier)
        tableView.separatorStyle = .none
        tableView.refreshControl = refreshControl
        
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        
        footerSpinner.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 44)
        tableView.tableFooterView = footerSpinner
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupBindings() {
        viewModel.$cars
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
                self?.refreshControl.endRefreshing()
            }
            .store(in: &viewModel.cancellables)
        
        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                if isLoading && self?.viewModel.cars.count ?? 0 > 0 {
                    self?.footerSpinner.startAnimating()
                } else {
                    self?.footerSpinner.stopAnimating()
                }
            }
            .store(in: &viewModel.cancellables)
    }

    @objc private func refreshData() {
        Task {
            await viewModel.refresh()
        }
    }
}

extension CarListingsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CarTableViewCell.identifier, for: indexPath) as! CarTableViewCell
        let car = viewModel.cars[indexPath.row]
        cell.configure(with: car)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let car = viewModel.cars[indexPath.row]
        viewModel.selectCar(car)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.cars.count - 2 && viewModel.canLoadmorePages {
            Task {
                await viewModel.loadMoreCars()
            }
        }
    }
}
