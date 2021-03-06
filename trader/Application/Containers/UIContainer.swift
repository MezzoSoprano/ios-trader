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
    func buy() -> UIViewController
    func currenciesFrom(selected: AccountBalance?, onSelect: @escaping Handler<AccountBalance>) -> UIViewController
    func currenciesTo(selected: AccountBalance?, onSelect: @escaping Handler<AccountBalance>) -> UIViewController
    func exchanges(onSelect: @escaping Handler<Exchange>) -> UIViewController
    func linkExchange(exchange: Exchange) -> UIViewController
}

// swiftlint:disable force_try
extension DependencyContainer: UIContainer {
    
    func currenciesFrom(selected: AccountBalance?, onSelect: @escaping Handler<AccountBalance>) -> UIViewController {
        return try! resolve(arguments: selected, onSelect) as CurrenciesFromViewController
    }
    
    func currenciesTo(selected: AccountBalance?, onSelect: @escaping Handler<AccountBalance>) -> UIViewController {
        return try! resolve(arguments: selected, onSelect) as CurrenciesToViewController
    }
    
    
    func buy() -> UIViewController {
        return try! resolve() as BuyCryptoViewController
    }
    
    func main() -> UIViewController {
        return try! resolve() as UITabBarController
    }
    
    func auth() -> UIViewController {
        return try! resolve() as BaseAuthViewController
    }
    
    func root() -> UIViewController {
        return try! resolve() as RootViewController
    }
    
    func exchanges(onSelect: @escaping Handler<Exchange>) -> UIViewController {
        return try! resolve(arguments: onSelect) as ExchangesViewController
    }
    
    func linkExchange(exchange: Exchange) -> UIViewController {
        return try! resolve(arguments: exchange) as LinkExchangeViewController
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
            controller.tabBar.tintColor = .systemYellow
            
            let controllers = [
                try container.resolve() as OrdersViewController,
                try container.resolve() as WelcomeViewController,
                try container.resolve() as SettingsViewController
            ]
            
            controller.viewControllers = controllers.map {
                let navController = UINavigationController(rootViewController: $0)
                navController.navigationBar.prefersLargeTitles = true
                return navController
            }
            controller.selectedIndex = 1
            
            return controller
        }
        
        container.register { () -> DashboardViewController in
            let controller = UIStoryboard.flows.instantiateViewController() as DashboardViewController
            controller.tabBarItem.image = #imageLiteral(resourceName: "icon_dashboard")
            return controller
        }
        
        container.register { () -> SettingsViewController in
            let controller = UIStoryboard.flows.instantiateViewController() as SettingsViewController
            controller.authService = try! container.resolve()
            controller.tabBarItem.image = #imageLiteral(resourceName: "icon_user")
            return controller
        }
        
        container.register { () -> WelcomeViewController in
            let controller = UIStoryboard.flows.instantiateViewController() as WelcomeViewController
            controller.tabBarItem.image = #imageLiteral(resourceName: "wallet")
            return controller
        }
        
        container.register { () -> BuyCryptoViewController in
            let controller = UIStoryboard.flows.instantiateViewController() as BuyCryptoViewController
            controller.tabBarItem.image = #imageLiteral(resourceName: "wallet")
            return controller
        }
        
        container.register { () -> OrdersViewController in
            let controller = UIStoryboard.flows.instantiateViewController() as OrdersViewController
            controller.tabBarItem.image = #imageLiteral(resourceName: "icon_dashboard")
            controller.orderService = try! container.resolve()
            return controller
        }
        
        container.register { () -> BaseAuthViewController in
            let controller = UIStoryboard.flows.instantiateViewController() as BaseAuthViewController
            controller.fauth = try! container.resolve()
            return controller
        }
        
        container.register { (onSelect: @escaping Handler<Exchange>) -> ExchangesViewController in
            let controller = UIStoryboard.flows.instantiateViewController() as ExchangesViewController
            controller.exchangeService = try! container.resolve()
            controller.onSelect = onSelect
            return controller
        }
        
        container.register { (exchange: Exchange) -> LinkExchangeViewController in
            let controller = UIStoryboard.flows.instantiateViewController() as LinkExchangeViewController
            controller.exchange = exchange
            controller.exchangeService = try! container.resolve()
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
