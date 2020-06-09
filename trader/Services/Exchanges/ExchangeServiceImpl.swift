//
//  ExchangeServiceImpl.swift
//  trader
//
//  Created by Svyatoslav Katola on 25.05.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import RxSwift
import FirebaseDatabase

class ExchangeServiceImpl {
    
    let client: DatabaseClient
    let database: DatabaseReference
    
    init(client: DatabaseClient,
         ref: DatabaseReference) {
        self.client = client
        self.database = ref
    }
}

extension ExchangeServiceImpl: ExchangeService {
    
    func linkedExchanges() -> Single<Exchange.Link> {
        return Single.create { [weak self] _ in
            self?.database.child(.users).child(.linkedExchanges).observeSingleEvent(of: .value, with: { snap in
                
                print(snap)
            })
            
            return Disposables.create()
        }
    }
    
    func link(exchange: Exchange.Link) -> Single<Void> {
        guard let dict = exchange.dictionary else { fatalError() }
        
        return Single.create { [weak self] observer in
            self?.database.child(.users)
                .child(.linkedExchanges)
                .childByAutoId()
                .updateChildValues(dict) { err, _ in
                err.map { observer(.error($0)) }
                observer(.success(()))
            }
            
            return Disposables.create()
        }
    }
    
    func availableExchanges() -> Single<[String]> {
        return client.get(route: .exchanges)
    }
}
