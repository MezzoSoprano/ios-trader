//
//  MainViewController.swift
//  trader
//
//  Created by Svyatoslav Katola on 23.05.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavBar()
    }
    
    var authService: AuthService!
}

extension MainViewController {
    
    private func configureNavBar() {
        navigationItem.rightBarButtonItem = .init(title: "Sign out", style: .plain,
                                                 target: self, action: #selector(signOut))
    }
    
    @objc func signOut() {
        authService
            .signOut()
            .subscribe(onError: { [weak self] in self?.presentAlert(with: $0.localizedDescription) })
            .disposed(by: rx.disposeBag)
    }
}
