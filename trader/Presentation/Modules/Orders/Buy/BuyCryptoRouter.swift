//
//  BuyCryptoRouter.swift
//  trader
//
//  Created by Svyatoslav Katola on 16.06.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import UIKit
import RxSwift

class BuyCryptoRouter: BuyCryptoRouterInput {
    
    let view: UIViewController
    
    init(view: UIViewController) {
        self.view = view
    }
    
    var output: BuyCryptoRouterOutput!
    
    func presentCurrenciesFrom(selected: AccountBalance?) {
//        let controller = assembly.ui.currenciesFrom(selected: selected) { balance in
//            self.output.currencyFromSelected(currency: balance)
//        }
//        
//        view.present(controller, animated: true)
    }
    
    func presentCurrenciesTo(selected: AccountBalance?) {
//        let controller = assembly.ui.currenciesTo(selected: selected) { balance in
//            self.output.currencyToSelected(currency: balance)
//        }
//
//        view.present(controller, animated: true)
    }
    
    func closeModule() {
        view.dismiss(animated: true)
    }
}
