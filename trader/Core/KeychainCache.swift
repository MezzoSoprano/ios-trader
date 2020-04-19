//
//  KeychainCache.swift
//  trader
//
//  Created by Svyatoslav Katola on 19.03.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import KeychainAccess

protocol KeyedCache {
    
    func get<T>(_ type: T.Type, forKey key: String) -> T? where T: Decodable
    func set<T>(_ value: T?, forKey key: String) where T: Encodable
    
    func removeAll()
    func remove(forKey key: String)
}

class KeychainCache {
    
    let keychain: Keychain
    let decoder: DataDecoder
    let encoder: DataEncoder
    
    init(keychain: Keychain,
         decoder: DataDecoder,
         encoder: DataEncoder) {
        self.keychain = keychain
        self.decoder = decoder
        self.encoder = encoder
    }
}

extension KeychainCache: KeyedCache {
    
    func get<T>(_ type: T.Type, forKey key: String) -> T? where T: Decodable {
        return try? keychain.getData(key)
            .flatMap { try? decoder.decode(type, from: $0) }
    }
    
    func set<T>(_ value: T?, forKey key: String) where T: Encodable {
        do {
            let data = try value.map(encoder.encode) ?? .init()
            try keychain.set(data, key: key)
        } catch {
            remove(forKey: key)
        }
    }
    
    func remove(forKey key: String) {
        try? keychain.remove(key)
    }
    
    func removeAll() {
        try? keychain.removeAll()
    }
    
    var description: String {
        return keychain.description
    }
    
    var debugDescription: String {
        return keychain.debugDescription
    }
}

protocol DataDecoder {
    
    func decode<D: Decodable>(_ type: D.Type, from: Data) throws -> D
}

protocol DataEncoder {
    
    func encode<E: Encodable>(_ value: E) throws -> Data
}

extension JSONDecoder: DataDecoder {}
extension JSONEncoder: DataEncoder {}
