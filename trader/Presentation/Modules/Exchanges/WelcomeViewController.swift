//
//  BotsViewController.swift
//  trader
//
//  Created by Svyatoslav Katola on 24.05.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if assembly.core.binance().authorized {
            self.navigationController?.setViewControllers([assembly.ui.linkedExchanges()], animated: true)
        }
    }
}

extension WelcomeViewController {
    
    @IBAction func createBot(_ sender: Any) {
        let controller = assembly.ui.exchanges { _ in () }
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
