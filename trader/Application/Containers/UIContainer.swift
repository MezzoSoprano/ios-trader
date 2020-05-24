//
//  UIContainer.swift
//  trader
//
//  Created by Svyatoslav Katola on 19.03.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import Dip
import UIKit

protocol UIContainer {
    
    func root() -> UIViewController
    func auth() -> UIViewController
    func main() -> UIViewController
}

// swiftlint:disable force_try
extension DependencyContainer: UIContainer {
    
    func main() -> UIViewController {
        return try! resolve() as UITabBarController
    }
    
    func auth() -> UIViewController {
        return try! resolve() as BaseAuthViewController
    }
    
    func root() -> UIViewController {
        return try! resolve() as RootViewController
    }
}

extension DependencyContainer {
    
    static func ui() -> DependencyContainer {
        let container = DependencyContainer()
        
        container.register { () -> RootViewController in
            let controller = UIStoryboard.main.instantiateViewController() as RootViewController
            controller.authService = try! container.resolve()
            return controller
        }
        
        container.register { () -> UITabBarController in
            let controller = UITabBarController()
            
            let controllers = [
                try container.resolve() as DashboardViewController,
                try container.resolve() as BotsViewController,
                try container.resolve() as ProfileViewController
            ]
            
            controller.viewControllers = controllers.map(UINavigationController.init)
            controller.selectedIndex = 2
            
            return controller
        }
        
        container.register { () -> DashboardViewController in
            let controller = UIStoryboard.flows.instantiateViewController() as DashboardViewController
            controller.tabBarItem.image = #imageLiteral(resourceName: "icon_dashboard")
            return controller
        }
        
        container.register { () -> ProfileViewController in
            let controller = UIStoryboard.flows.instantiateViewController() as ProfileViewController
            controller.authService = try! container.resolve()
            controller.tabBarItem.image = #imageLiteral(resourceName: "icon_user")
            return controller
        }
        
        container.register { () -> BotsViewController in
            let controller = UIStoryboard.flows.instantiateViewController() as BotsViewController
            controller.tabBarItem.image = #imageLiteral(resourceName: "icon_bot")
            return controller
        }
        
        container.register { () -> BaseAuthViewController in
            let controller = UIStoryboard.flows.instantiateViewController() as BaseAuthViewController
            controller.fauth = try! container.resolve()
            return controller
        }
        
        return container
    }
}

extension UIStoryboard {
    
    static let main = UIStoryboard(name: "Main", bundle: nil)
    static let flows = UIStoryboard(name: "Flows", bundle: nil)
}

extension UIStoryboard {
    
    func instantiateViewController<ViewController: UIViewController>(withIdentifier identifier: String = .init(describing: ViewController.self)) -> ViewController {
        guard let controller = instantiateViewController(withIdentifier: identifier) as? ViewController else {
            fatalError("Could not find \(ViewController.self) in \(self)")
        }
        
        return controller
    }
}
