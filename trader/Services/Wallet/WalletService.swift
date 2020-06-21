//
//  WalletService.swift
//  trader
//
//  Created by Svyatoslav Katola on 21.06.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import RxSwift

protocol WalletService {
    
    func accounts(exchange: Exchange) -> Single<[AccountBalance]>
    func activeAccounts(exchange: Exchange, except: AccountBalance?) -> Single<[AccountBalance]>
}
