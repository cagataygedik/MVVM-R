//
//  BaseHostingViewController.swift
//  MVVM-R
//
//  Created by Celil Çağatay Gedik on 22.07.2025.
//

import SwiftUI
import UIKit

class BaseHostingViewController<Content: View, V: BaseHostingViewModelProtocol>: UIHostingController<Content> {
    let viewModel: V
    
    init(rootView: Content, viewModel: V) {
        self.viewModel = viewModel
        super.init(rootView: rootView)
    }
    
    @MainActor @preconcurrency required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.viewDidApppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.viewWillDisappear()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.viewDidDisappear()
    }
}
