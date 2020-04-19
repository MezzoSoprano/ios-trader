//
//  UIContainer.swift
//  trader
//
//  Created by Svyatoslav Katola on 19.03.2020.
//  Copyright © 2020 Teamvoy. All rights reserved.
//

import Dip
import UIKit

protocol UIContainer {
    
    func root() -> UIViewController
}

// swiftlint:disable force_try
extension DependencyContainer: UIContainer {
    
    func root() -> UIViewController {
        return try! resolve() as RootViewController
    }
}

extension DependencyContainer {
    
    static func ui() -> DependencyContainer {
        let container = DependencyContainer()
        
        container.register { () -> RootViewController in
            let controller = UIStoryboard.main.instantiateViewController() as RootViewController
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
