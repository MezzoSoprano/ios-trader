//
//  BaseAuthViewController.swift
//  trader
//
//  Created by Svyatoslav Katola on 23.05.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import UIKit
import FirebaseUI

class BaseAuthViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fauth.delegate = self
        fauth.providers = [
            FUIGoogleAuth(),
            FUIEmailAuth()
        ]
        
        let authVC = fauth.authViewController()
        set(authVC, animated: true)
    }
    
    var fauth: FUIAuth!
}

extension BaseAuthViewController {
    
    private func set(_ viewController: UIViewController, animated: Bool) {
        dismiss(animated: true)
        children.forEach { $0.removeAsChild() }
        add(сhild: viewController, to: view)
    }
}

extension BaseAuthViewController: FUIAuthDelegate { }
