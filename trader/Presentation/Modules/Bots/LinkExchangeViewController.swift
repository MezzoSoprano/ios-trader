//
//  LinkExchangeViewController.swift
//  trader
//
//  Created by Svyatoslav Katola on 25.05.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import UIKit

class LinkExchangeViewController: UIViewController {

    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var apiKeyLabel: UITextField!
    @IBOutlet weak var secretApiKeyLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    var exchange: Exchange!
    var exchangeService: ExchangeService!
}

extension LinkExchangeViewController {
    
    @IBAction func linkExchange(_ sender: Any) {
        guard let name = titleLabel.text,
            let apiKey =  apiKeyLabel.text,
            let secretKey = secretApiKeyLabel.text else { return }
        
        exchangeService.link(exchange: .init(name: name, apiKey: apiKey,
                                             secretKey: secretKey,
                                             exchangeName: exchange.rawValue))
            .subscribe(onSuccess: { [weak self] in self?.succeed() })
            .disposed(by: rx.disposeBag)
    }
    
    func configure(with exchange: Exchange) {
        title = "Connect \(exchange.rawValue.uppercased())"
    }
    
    func succeed() {
        print("success")
    }
}
