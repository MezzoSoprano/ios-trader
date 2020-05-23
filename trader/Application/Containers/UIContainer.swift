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
    
    func root() -> RootViewController
    func main() -> MainViewController
    func auth() -> BaseAuthViewController
}

// swiftlint:disable force_try
extension DependencyContainer: UIContainer {
    
    func main() -> MainViewController {
        return try! resolve() as MainViewController
    }
    
    func auth() -> BaseAuthViewController {
        return try! resolve() as BaseAuthViewController
    }
    
    func root() -> RootViewController {
        return try! resolve() as RootViewController
    }
}

extension DependencyContainer {
    
    static func ui() -> DependencyContainer {
        let container = DependencyContainer()
        
        container.register { () -> MainViewController in
            let controller = UIStoryboard.main.instantiateViewController() as MainViewController
            controller.authService = try! container.resolve()
            return controller
        }
        
        container.register { () -> BaseAuthViewController in
            let controller = UIStoryboard.main.instantiateViewController() as BaseAuthViewController
            controller.fauth = try! container.resolve()
            return controller
        }
        
        container.register { () -> RootViewController in
            let controller = UIStoryboard.main.instantiateViewController() as RootViewController
            controller.authService = try! container.resolve()
            return controller
        }
        
        return container
    }
}

extension UIStoryboard {
    
    static let main = UIStoryboard(name: "Main", bundle: nil)
}

extension UIStoryboard {
    
    func instantiateViewController<ViewController: UIViewController>(withIdentifier identifier: String = .init(describing: ViewController.self)) -> ViewController {
        guard let controller = instantiateViewController(withIdentifier: identifier) as? ViewController else {
            fatalError("Could not find \(ViewController.self) in \(self)")
        }
        
        return controller
    }
}
