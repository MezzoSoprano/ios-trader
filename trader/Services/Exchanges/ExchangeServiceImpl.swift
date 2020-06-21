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
import CodableFirebase

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
    
    func linkedExchanges() -> Single<[Exchange.Linked]> {
        return Single.create { [weak self] observer in
            self?.database.child(.users).child(.linkedExchanges).observeSingleEvent(of: .value, with: { snap in
                
                guard let value = snap.value as? [String: Any] else { return }

                do {
                  let exchanges = try FirebaseDecoder().decode([Exchange.Linked].self, from: Array(value.values))
                    observer(.success(exchanges))
//                    exchanges.filter {
//                        guard let pass = self?.cache.get(Exchange.AuthKey.self, forKey: $0.secretKeyDecrypted) else { return false }
//
//                        let keyForEncrypt = $0.secretKeyDecrypted.data(using: .utf8)
//                        let tag = keyForEncrypt!.base64EncodedData()
//                        let nonce = try! AES.GCM.Nonce(data: Data(base64Encoded: "fv1nixTVoYpSvpdA")!)
//
//                        // Decrypt
//                        let sealedBoxRestored = try! AES.GCM.SealedBox(nonce: nonce, ciphertext: sealedBox.ciphertext, tag: tag)
//                        let decrypted = try! AES.GCM.open(encrypted, using: key, authenticating: tag)
//                        _ = String.init(data: decrypted, encoding: .utf8).map { print($0) }
//
//                    }
                    
                } catch let decodeError {
                    observer(.error(decodeError))
                }
            })
            
            return Disposables.create()
        }
    }
    
    func link(exchange: Exchange.Link) -> Single<Void> {
        binance.key = exchange.apiKey
        binance.secret = exchange.secretKey
        
        let stringToEncrypt = exchange.secretKey.data(using: .utf8)
        let keyForEncrypt = exchange.passsword.data(using: .utf8)
        
        // HERE
        let key = SymmetricKey(size: .bits256)
        
        let nonce = try! AES.GCM.Nonce(data: Data(base64Encoded: "fv1nixTVoYpSvpdA")!)
        let tag = keyForEncrypt!.base64EncodedData()
        
        // Encrypt
        let sealedBox = try! AES.GCM.seal(stringToEncrypt!, using: key, nonce: nonce, authenticating: tag)
        
        // Decrypt
        let encrypted = try! AES.GCM.SealedBox(combined: sealedBox.combined!)
        let decrypted = try! AES.GCM.open(encrypted, using: key, authenticating: tag)
        _ = String.init(data: decrypted, encoding: .utf8).map { print($0) }
        
        let encryptedString = encrypted.ciphertext.base64EncodedString()
        
        let linked = Exchange.Linked.init(from: exchange, decrypted: encryptedString)
        guard let dict = linked.dictionary else { fatalError() }
        
//        let key = SymmetricKey(size: .bits256)
//        let encrypted = try! AES.GCM.seal(stringToEncrypt!, using: key, authenticating: keyForEncrypt!)
//        let encryptedString = encrypted.ciphertext.base64EncodedString()
//
//        let linked = Exchange.Linked.init(from: exchange, decrypted: encryptedString)
//        guard let dict = linked.dictionary else { fatalError() }
//        cache.set(encrypted, forKey: "ds")
//
//        let cont = try! AES.GCM.SealedBox.init(nonce: .init(), ciphertext: encrypted.ciphertext, tag: Data())
//
//        let decrypted = try! AES.GCM.open(cont, using: key, authenticating: keyForEncrypt!)
//        _ = String.init(data: decrypted, encoding: .utf8).map { print($0) }
        
        return Single.create { [weak self] observer in
            self?.binance.account(success: { acc in
                print(acc)
                self?.database.child(.users)
                    .child(.linkedExchanges)
                    .childByAutoId()
                    .updateChildValues(dict) { err, _ in
                    err.map { observer(.error($0)) }
                    
                    self?.cache.set(Exchange.AuthKey.init(key: exchange.passsword), forKey: encryptedString)
//                    print(self?.cache.get(Exchange.AuthKey.self, forKey: encryptedString))
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

extension Exchange {
    
    struct Linked: Codable {
        
        let name: String
        let apiKey: String
        var secretKeyDecrypted: String
        
        init(from: Exchange.Link, decrypted: String) {
            self.name = from.name
            self.apiKey = from.apiKey
            self.secretKeyDecrypted = decrypted
        }
    }
}
