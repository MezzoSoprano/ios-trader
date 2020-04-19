//
//  CoreContainer.swift
//  safeline
//
//  Created by Svyatoslav Katola on 19.03.2020.
//  Copyright © 2020 Teamvoy. All rights reserved.
//

import Core
import Dip
import Foundation
import KeychainAccess

protocol CoreContainer {
    
    func keychain() -> KeyedCache
}

// swiftlint:disable force_try
extension DependencyContainer: CoreContainer {
    
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
        
        return container
    }
}
