//
//  FavoritesViewController.swift
//  MVVM-R
//
//  Created by Celil Çağatay Gedik on 10.07.2025.
//

import UIKit
import Combine
import SwiftUI

final class FavoritesViewController: UIViewController {
    private let tableView = UITableView()
    private let emptyStateLabel = UILabel()
    
    private let favoritesManager = FavoritesManager.shared
    private let router: Router
    
    init(router: Router) {
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupBindings()
    }
    
    private func setupLayout() {
        view.backgroundColor = .systemBackground
        title = "Favorites"
        
        view.addSubview(tableView)
        view.addSubview(emptyStateLabel)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CarTableViewCell.self, forCellReuseIdentifier: CarTableViewCell.identifier)
        tableView.separatorStyle = .none
        
        emptyStateLabel.text = "No Favorites Yet"
        emptyStateLabel.textColor = .secondaryLabel
        emptyStateLabel.font = .systemFont(ofSize: 18, weight: .medium)
        emptyStateLabel.textAlignment = .center
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        emptyStateLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        updateEmptyState()
    }
    
    private func setupBindings() {
        favoritesManager.$favorites
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
                self?.updateEmptyState()
            }
            .store(in: &cancellables)
    }
    
    private func updateEmptyState() {
        let isEmpty = favoritesManager.favorites.isEmpty
        emptyStateLabel.isHidden = !isEmpty
        tableView.isHidden = isEmpty
    }
    
    private var cancellables = Set<AnyCancellable>()
}

extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritesManager.favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CarTableViewCell.identifier) as! CarTableViewCell
        let car = favoritesManager.favorites[indexPath.row]
        cell.configure(with: car)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let car = favoritesManager.favorites[indexPath.row]
        let carDetailView = CarDetailView(car: car, router: router)
        let hostingController = UIHostingController(rootView: carDetailView)
        navigationController?.pushViewController(hostingController, animated: true)
    }
}
