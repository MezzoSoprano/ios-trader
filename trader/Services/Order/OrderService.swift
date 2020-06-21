//
//  OrderService.swift
//  trader
//
//  Created by Svyatoslav Katola on 09.06.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import RxSwift

protocol OrderService {
    
    func all() -> Single<[Order]>
    func remove(order: Order) -> Single<Void>
    func placeOrder(accountTo: AccountBalance, accountFrom: AccountBalance, amount: Double, price: Double) -> Single<Void>
}
