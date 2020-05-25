//
//  BotsViewController.swift
//  trader
//
//  Created by Svyatoslav Katola on 24.05.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import UIKit

class BotsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension BotsViewController {
    
    @IBAction func createBot(_ sender: Any) {
        let controller = assembly.ui.linkExchange { _ in () }
        present(controller, animated: true)
    }
}
