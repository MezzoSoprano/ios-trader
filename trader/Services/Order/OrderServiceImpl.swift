//
//  OrderServiceImpl.swift
//  trader
//
//  Created by Svyatoslav Katola on 09.06.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import RxSwift

class OrderServiceImpl {
    
    let binanceClient: BinanceAPI
    
    init(client: BinanceAPI) {
        self.binanceClient = client
    }
}

extension OrderServiceImpl: OrderService {
    
    func placeOrder(accountTo: AccountBalance, accountFrom: AccountBalance, amount: Double, price: Double) -> Single<Void> {
        let sympol = accountFrom.asset + accountTo.asset
        
        return .create { observer in
            self.binanceClient.placeOrder(market: sympol,
                                          quantity: amount,
                                          rate: price,
                                          success: { _ in observer(.success(()))
            },
                                          failure: { observer(.error($0)) })
            return Disposables.create()
        }
    }
    
    func remove(order: Order) -> Single<Void> {
        return.create { o in
            self.binanceClient.cancelOrder(symbol: order.symbol,
                                           orderId: order.orderId,
                                           success: { _ in o(.success(())) },
                                           failure: {  o(.error($0)) })
            return Disposables.create()
        }
    }

    func all() -> Single<[Order]> {
        return .create { observer in
            
            self.binanceClient.getAllOrders(symbol: "BTCUSDT",
                                            success: { orders in
                observer(.success(orders))
            }, failure: { err in
                observer(.error(err))
            })
            
            return Disposables.create()
        }
    }
}
