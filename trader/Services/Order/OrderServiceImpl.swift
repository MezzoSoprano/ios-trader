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
    
    func remove(order: Order) {
        binanceClient.cancelOrder(symbol: order.symbol, orderId: order.orderId, success: { _ in () }, failure: { print($0) })
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
