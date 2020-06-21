//
//  WalletServiceImpl.swift
//  trader
//
//  Created by Svyatoslav Katola on 21.06.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import Foundation
import RxSwift

class WalletServiceImpl {
    
    let binance: BinanceAPI
    
    init(client: BinanceAPI) {
        self.binance = client
    }
}

extension WalletServiceImpl: WalletService {
    
    func activeAccounts(exchange: Exchange, except: AccountBalance?) -> Single<[AccountBalance]> {
        return Single.create { observer in
            self.binance.account(success: {
                observer(.success($0.balances.filter { (Double($0.free).map { a in a > 0 } ?? true) && $0.asset != except?.asset }))
            }) { observer(.error($0))
            }
            
            return Disposables.create()
        }
    }
    
    func accounts(exchange: Exchange) -> Single<[AccountBalance]> {
        return Single.create { observer in
            self.binance.account(success: {
                observer(.success($0.balances))
            }) { observer(.error($0))
            }
            
            return Disposables.create()
        }
    }
}
