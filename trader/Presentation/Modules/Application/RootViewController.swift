//
//  RootViewController.swift
//  trader
//
//  Created by Svyatoslav Katola on 19.03.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import UIKit
import RxSwift

class RootViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authService.sessionUpdates()
            .subscribeOn(MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] in $0 == nil ? self?.presentWelcome() : self?.presentMain() })
            .disposed(by: rx.disposeBag)
    }
    
    var authService: AuthService!
}

extension RootViewController {
    
    private func set(_ viewController: UIViewController, animated: Bool) {
        dismiss(animated: true)
        children.forEach { $0.removeAsChild() }
        add(сhild: viewController, to: view)
    }
    
    private func presentWelcome() {
        set(assembly.ui.auth(), animated: true)
    }
    
    private func presentMain() {
        set(assembly.ui.main(), animated: true)
    }
}
