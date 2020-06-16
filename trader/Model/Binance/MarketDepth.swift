//
//  BinanceAPI.swift
//  trader
//
//  Created by Svyatoslav Katola on 09.06.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import Foundation

public struct MarketDepth: Codable {
    
    public var lastUpdateId: Int
    public var bids: [PriceQuantity]
    public var asks: [PriceQuantity]
    
    init() {
        self.lastUpdateId = 0
        self.bids = []
        self.asks = []
    }
}

public struct PriceQuantity: Codable {
    
    public var price: String
    public var quantity: String

    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        self.price = try container.decode(String.self)
        self.quantity = try container.decode(String.self)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        try container.encode(price)
        try container.encode(quantity)
//        try container.encode([])
    }
}
