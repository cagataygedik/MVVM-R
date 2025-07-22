//
//  BaseHostingViewModel.swift
//  MVVM-R
//
//  Created by Celil Çağatay Gedik on 22.07.2025.
//

import Foundation
import Combine

protocol BaseHostingViewModelProtocol: ObservableObject {
    func viewDidLoad()
    func viewWillAppear()
    func viewDidApppear()
    func viewWillDisappear()
    func viewDidDisappear()
}

class BaseHostingViewModel<R: BaseRouterProtocol>: BaseHostingViewModelProtocol {
    let router: R
    var cancellables = Set<AnyCancellable>()
    
    init(router: R) {
        self.router = router
    }
    
    func viewDidLoad() {}
    func viewWillAppear() {}
    func viewDidApppear() {}
    func viewWillDisappear() {}
    func viewDidDisappear() {}
}
