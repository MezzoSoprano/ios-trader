//
//  BuyCryptoProtocols.swift
//  trader
//
//  Created by Svyatoslav Katola on 16.06.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import Foundation
import UIKit

// MARK: - View

protocol BuyCryptoViewInput: class {
    
    func configure(with new: [Order])
    func configure(with error: Error)
    func configureWithSuccess()
}

protocol BuyCryptoViewOutput: class {

    func viewDidLoad()
    func selectCurrencyFrom()
    func selectCurrencyTo()
    func createOrder()
    func priceDidChange(price: Double)
    func amountDidChange(amount: Double)
}

// MARK: - Interactor

protocol BuyCryptoInteractorInput {
    
    func startWebSockets(symbol: String)
    func createOrder(market: String, quantity: Double, rate: Double)
}

protocol BuyCryptoInteractorOutput: class {
    
    func webScoketNew(orders: [Order])
    func orderSucceded(order: Order)
    func error(error: Error)
}

// MARK: - Router

protocol BuyCryptoRouterInput {
    
    func presentCurrenciesFrom(selected: AccountBalance?)
    func presentCurrenciesTo(selected: AccountBalance?)
    func closeModule()
}

protocol BuyCryptoRouterOutput {
    
    func currencyFromSelected(currency: AccountBalance)
    func currencyToSelected(currency: AccountBalance)
}
