//
//  CoreContainer.swift
//  trader
//
//  Created by Svyatoslav Katola on 19.03.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

//import Core
import Dip
import Foundation
import KeychainAccess
import FirebaseUI
import FirebaseDatabase

protocol CoreContainer {
    
    func keychain() -> KeyedCache
    func firebaseAuth() -> FUIAuth
}

// swiftlint:disable force_try
extension DependencyContainer: CoreContainer {
        
    func firebaseAuth() -> FUIAuth {
        return try! resolve() as FUIAuth
    }
    
    func keychain() -> KeyedCache {
        return try! resolve() as KeyedCache
    }
}

extension DependencyContainer {
    
    static func core() -> DependencyContainer {
        let container = DependencyContainer()
        
        container.register(.singleton) { () -> DataDecoder in
            return JSONDecoder()
        }
        
        container.register(.singleton) { () -> DataEncoder in
            return JSONEncoder()
        }
        
        container.register(.singleton) { () -> KeyedCache in
            guard let identifier = Bundle.main.bundleIdentifier else { fatalError() }
            let keychain = Keychain(service: identifier).accessibility(.whenUnlockedThisDeviceOnly)
            let cache = KeychainCache(keychain: keychain,
                                      decoder: try container.resolve(),
                                      encoder: try container.resolve())
            return cache as KeyedCache
        }
        
        container.register(.singleton) { () -> FUIAuth in
            return .defaultAuthUI()!
        }
        
        container.register(.singleton) { () -> Auth in
            return .auth()
        }
        
        container.register(.singleton) { () -> DatabaseReference in
            return Database.database().reference()
        }
        
        container.register(.singleton) { () -> DatabaseClient in
            return FirebaseDatabaseClient(database: try container.resolve())
        }
        
        container.register(.singleton) { () -> BinanceAPI in
            return BinanceAPI(key: "XtA43wkvvCJMcmNvTbAuVzQTOocMT2Ym6JSaE14TLTpyIr99GTDr4fTMz2GagDDB",
                              secret: "rNIoEgVCIw3nkfKtK7z3zqS3I9wOOPejlX8l2hxg8SKIoZTL7ssO1vfpcYilHfFq")
        }
        
        return container
    }
}
