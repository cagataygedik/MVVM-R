//
//  Extension+UIApplication.swift
//  MVVM-R
//
//  Created by Celil Çağatay Gedik on 22.07.2025.
//

import UIKit

extension UIApplication {
    
    func topMostViewController() -> UIViewController? {
        guard let windowScene = self.connectedScenes.first as? UIWindowScene,
              let keyWindow = windowScene.windows.first(where: { $0.isKeyWindow }) else {
            return nil
        }
        
        if var topController = keyWindow.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        return nil
    }
}
