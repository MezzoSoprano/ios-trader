//
//  ExchangeServiceImpl.swift
//  trader
//
//  Created by Svyatoslav Katola on 25.05.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import RxSwift
import FirebaseDatabase
import CryptoKit

class ExchangeServiceImpl {
    
    let client: DatabaseClient
    let database: DatabaseReference
    let binance: BinanceAPI
    let cache: KeyedCache
    
    init(client: DatabaseClient,
         ref: DatabaseReference,
         binance: BinanceAPI,
         cache: KeyedCache) {
        self.client = client
        self.database = ref
        self.binance = binance
        self.cache = cache
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
        var exch = exchange
        
        binance.key = exchange.apiKey
        binance.secret = exchange.secretKey
        
        let pasword = exchange.secretKey.data(using: .utf8)
        let text = exchange.passsword.data(using: .utf8)
        let key = SymmetricKey(size: .bits256)
        let encrypted = try! AES.GCM.seal(text!, using: key, authenticating: pasword!)
        let encryptedString = encrypted.ciphertext.base64EncodedString() //else { fatalError() }
        exch.secretKey = encryptedString
        guard let dict = exchange.dictionary else { fatalError() }
        
        return Single.create { [weak self] observer in
            self?.binance.account(success: { acc in
                print(acc)
                self?.database.child(.users)
                    .child(.linkedExchanges)
                    .childByAutoId()
                    .updateChildValues(dict) { err, _ in
                    err.map { observer(.error($0)) }
                    
                    self?.cache.set(Exchange.AuthKey.init(key: exchange.passsword), forKey: encryptedString)
                        print(self?.cache.get(Exchange.AuthKey.self, forKey: encryptedString))
                    observer(.success(()))
                }
                
            }) { err in
                observer(.error(err))
            }
            
            return Disposables.create()
        }
    }
    
    func availableExchanges() -> Single<[String]> {
        return client.get(route: .exchanges)
    }
}

//let pasword = "password".data(using: .utf8)
//let text = "text".data(using: .utf8)
//
//      let encrypted = try! AES.GCM.seal(text!, using: .init(data: pasword!))
//let key = SymmetricKey(size: .bits256)
//let encrypted = try! AES.GCM.seal(text!, using: key, authenticating: pasword!)
//let decrypted = try! AES.GCM.open(encrypted, using: key, authenticating: pasword!)
//
//_ = String.init(data: decrypted, encoding: .utf8).map { print($0) }

extension Exchange {
    
    struct AuthKey: Codable {
        
        var key: String
    }
}
