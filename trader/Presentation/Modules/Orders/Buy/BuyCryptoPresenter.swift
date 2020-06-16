//
//  BuyCryptoPresenter.swift
//  trader
//
//  Created by Svyatoslav Katola on 16.06.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import Foundation

final class BuyCryptoPresenter {
    
    var view: BuyCryptoViewInput!
    var interactor: BuyCryptoInteractorInput!
    var router: BuyCryptoRouterInput!
    
    var order: Order.Create = .init()
}

extension BuyCryptoPresenter: BuyCryptoRouterOutput {
    
    func currencyFromSelected(currency: AccountBalance) {
        order.market.append(currency.asset)
    }
    
    func currencyToSelected(currency: AccountBalance) {
        order.market.append(currency.asset)
    }
}

extension BuyCryptoPresenter: BuyCryptoViewOutput {
    
    func viewDidLoad() {
        interactor.startWebSockets(symbol: order.market)
    }
    
    func selectCurrencyFrom() {
        router.presentCurrenciesFrom(selected: nil)
    }
    
    func selectCurrencyTo() {
        router.presentCurrenciesFrom(selected: nil)
    }
    
    func createOrder() {
        interactor.createOrder(market: order.market, quantity: order.quantity, rate: order.rate)
    }
    
    func priceDidChange(price: Double) {
        order.rate = price
    }
    
    func amountDidChange(amount: Double) {
        order.quantity = amount
    }
}

extension BuyCryptoPresenter: BuyCryptoInteractorOutput {
    
    func webScoketNew(orders: [Order]) {
        view.configure(with: orders)
    }
    
    func orderSucceded(order: Order) {
        view.configureWithSuccess()
    }
    
    func error(error: Error) {
        view.configure(with: error)
    }
}

extension Order {
    
    struct Create {
        
        var market: String
        var quantity: Double
        var rate: Double
        
        init() {
            market = "USD/BTC"
            quantity = 0
            rate = 0
        }
    }
}
