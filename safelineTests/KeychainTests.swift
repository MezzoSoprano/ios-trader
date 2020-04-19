//
//  KeychainTests.swift
//  safelineTests
//
//  Created by Svyatoslav Katola on 20.03.2020.
//  Copyright © 2020 Teamvoy. All rights reserved.
//

import XCTest
@testable import SafeLine_VPN

final class KeychainTests: XCTestCase {
    
    let userKey  = "User"
    let usersKey = "Users"
    
    let testUser: User = .init(id: 11, email: "22", password: "333")
    let testUSers: [User] = [.init(id: 1, email: "email1", password: "pass1"),
                             .init(id: 2, email: "email2", password: "pass2"),
                             .init(id: 3, email: "email3", password: "pass3")]
    
    let keyChain = KeychainCache(keychain: .init(),
                                 decoder: JSONDecoder(),
                                 encoder: JSONEncoder())
    
    override func setUp() {
        keyChain.set(testUser, forKey: userKey)
        keyChain.set(testUSers, forKey: usersKey)
    }
    
    func testGet() {
        let users: [User]? = keyChain.get(forKey: usersKey)
        XCTAssertEqual(users, testUSers)
    }
    
    func testSet() {
        XCTAssertEqual(keyChain.get(forKey: userKey), testUser)
    }
    
    func testRemove() {
        keyChain.remove(forKey: userKey)
        
        XCTAssertNil(keyChain.get(forKey: userKey) as User?)
    }
}

extension KeychainTests {
    
    struct User: Codable, Equatable {
        
        let id: Int
        let email: String
        let password: String
    }
}
