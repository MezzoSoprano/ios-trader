//
//  BinanceAPI.swift
//  trader
//
//  Created by Svyatoslav Katola on 09.06.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import Foundation

public struct Balance: Decodable {
    public let currency: String
    public let balance: Double
    public let available: Double
    public let pending: Double
    public let cryptoAddress: String?
    public let uuid: String?
    
    public enum CodingKeys: String, CodingKey {
        case currency = "Currency"
        case balance = "Balance"
        case available = "Available"
        case pending = "Pending"
        case cryptoAddress = "CryptoAddress"
        case uuid = "Uuid"
    }
}
