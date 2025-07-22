//
//  BaseViewModel.swift
//  MVVM-R
//
//  Created by Celil Çağatay Gedik on 22.07.2025.
//

import Foundation
import Combine

protocol BaseViewModelProtocol {
    func viewDidLoad()
    func viewWillAppear()
    func viewDidApppear()
    func viewWillDisappear()
    func viewDidDisappear()
}

class BaseViewModel<R: BaseRouterProtocol>: ObservableObject, BaseViewModelProtocol {
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
