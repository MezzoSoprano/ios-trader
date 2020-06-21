//
//  RootViewController.swift
//  trader
//
//  Created by Svyatoslav Katola on 19.03.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import UIKit
import RxSwift
import CryptoKit

class RootViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authService.sessionUpdates()
            .subscribeOn(MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] in $0 == nil ? self?.presentWelcome() : self?.presentMain() })
            .disposed(by: rx.disposeBag)
        
        let key = "password".data(using: .utf8)
        let text = "text".data(using: .utf8)
        
        let sk = SymmetricKey(size: .bits256)
        let encrypted = try! AES.GCM.seal(text!, using: sk, authenticating: key!)
        let decrypted = try! AES.GCM.open(encrypted, using: sk, authenticating: key!)
        
        _ = String.init(data: decrypted, encoding: .utf8).map { print($0) }
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
