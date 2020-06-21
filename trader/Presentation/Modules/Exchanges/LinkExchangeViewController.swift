//
//  LinkExchangeViewController.swift
//  trader
//
//  Created by Svyatoslav Katola on 25.05.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import UIKit
import RxSwift

class LinkExchangeViewController: UIViewController {

//    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var apiKeyLabel: UITextField!
    @IBOutlet weak var secretApiKeyLabel: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    var exchange: Exchange!
    var exchangeService: ExchangeService!
}

extension LinkExchangeViewController {
    
    @IBAction func linkExchange(_ sender: Any) {
        guard let apiKey =  apiKeyLabel.text,
            let secretKey = secretApiKeyLabel.text,
            let password = passwordTextField.text else { return }
        
        exchangeService.link(exchange: .init(name: exchange.rawValue,
                                             passsword: password,
                                             apiKey: apiKey,
                                             secretKey: secretKey)).observeOn(MainScheduler.asyncInstance)
            .subscribe(onSuccess: { [weak self] in self?.succeed() },
                       onError: { _ in self.configure(error: "") })
            .disposed(by: rx.disposeBag)
    }
    
    func configure(with exchange: Exchange) {
        title = "Connect \(exchange.rawValue.uppercased())"
    }
    
    func succeed() {
        let controller = assembly.ui.linkedExchanges()
        self.navigationController?.setViewControllers([controller], animated: true)
    }
    
    func configure(error: String) {
        let alert: UIAlertController = .init(title: "Error happend while procceding",
                                             message: "Incorrect API key, please try again!",
                                             preferredStyle: .alert)
        alert.addAction(.init(title: "OK", style: .cancel))
            
        present(alert, animated: true)
    }
}
