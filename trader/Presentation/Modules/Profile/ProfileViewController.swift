//
//  ProfileViewController.swift
//  trader
//
//  Created by Svyatoslav Katola on 24.05.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavBar()
    }
    
    var authService: AuthService!
}

extension ProfileViewController {
    
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
