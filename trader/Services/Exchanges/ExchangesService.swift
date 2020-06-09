//
//  ExchangesService.swift
//  trader
//
//  Created by Svyatoslav Katola on 25.05.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import RxSwift

protocol ExchangeService {
    
    func availableExchanges() -> Single<[String]>
    func link(exchange: Exchange.Link) -> Single<Void>
    func linkedExchanges() -> Single<Exchange.Link>
}
