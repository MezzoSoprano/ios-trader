//
//  MarketService.swift
//  trader
//
//  Created by Svyatoslav Katola on 16.06.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import Foundation
import RxSwift

protocol TransferService {
    
    func createBittrexOrder(market: String, quantity: Double, rate: Double) -> Single<Void>
    func createBinanceOrder(market: String, quantity: Double, rate: Double) -> Single<Void>
}

class TransferServiceImpl {
    
    let binance: BinanceAPI
    let bittrex: Bittrex
    
    init(binance: BinanceAPI,
         bittrex: Bittrex) {
        self.binance = binance
        self.bittrex = bittrex
    }
}

extension TransferServiceImpl: TransferService {
    
    func createBittrexOrder(market: String, quantity: Double, rate: Double) -> Single<Void> {
        return .create { observer in
            self.bittrex.buyLimit(market: market, quantity: quantity, rate: rate) { response in
                switch response {
                case .failure(let err):
                    observer(.error(err))
                case .success(_):
                    observer(.success(()))
                }
            }
            
            return Disposables.create()
        }
    }
    
    func createBinanceOrder(market: String, quantity: Double, rate: Double) -> Single<Void> {
        return .create { observer in
            self.binance.placeOrder(market: market, quantity: quantity, rate: rate,
                                    success: { _ in observer(.success(()))
            }) { error in
                observer(.error(error))
            }
            
            return Disposables.create()
        }
    }
}
