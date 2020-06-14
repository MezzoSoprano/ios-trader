//
//  UIViewController.swift
//  trader
//
//  Created by Svyatoslav Katola on 23.05.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import UIKit

extension UIViewController {
    
    var topViewController: UIViewController {
        guard let controller = presentedViewController else {
            return self
        }
        
        if let navigation = controller as? UINavigationController {
            return navigation.visibleViewController!.topViewController
        }
        
        if let tab = controller as? UITabBarController {
            if let selectedTab = tab.selectedViewController {
                return selectedTab.topViewController
            }
            
            return tab.topViewController
        }
        
        return controller.topViewController
    }
    
    func add(сhild controller: UIViewController, to view: UIView) {
        addChild(controller)
        
        view.addSubview(controller.view)
        controller.view.frame = view.bounds
        controller.view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        controller.didMove(toParent: self)
    }
    
    func removeAsChild() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }

    func presentAlert(with error: String) {
        let controller = UIAlertController(title: nil,
                                           message: error,
                                           preferredStyle: .alert)
        controller.addAction(.init(title: Localization.ok, style: .cancel))
        present(controller, animated: true)
    }
}

extension UINavigationController {
    
    func replaceTopViewController(with viewController: UIViewController, animated: Bool) {
        guard let rootViewController = viewControllers.first else { return }
        self.setViewControllers([rootViewController, viewController], animated: animated)
    }
}
