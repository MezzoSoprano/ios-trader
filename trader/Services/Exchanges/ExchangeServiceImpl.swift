//
//  ExchangeServiceImpl.swift
//  trader
//
//  Created by Svyatoslav Katola on 25.05.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import RxSwift

class ExchangeServiceImpl {
    
    let client: DatabaseClient
    
    init(client: DatabaseClient) {
        self.client = client
    }
}

extension ExchangeServiceImpl: ExchangeService {
    
    func availableExchanges() -> Single<[String]> {
        return client.get(route: .exchanges)
    }
}
