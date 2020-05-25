//
//  DashboardViewController.swift
//  trader
//
//  Created by Svyatoslav Katola on 24.05.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        exchangeService
            .availableExchanges()
            .subscribe { print($0) }
            .disposed(by: rx.disposeBag)
    }
    
    var exchangeService: ExchangeService!
}
