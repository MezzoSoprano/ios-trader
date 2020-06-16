//
//  BinanceAPI.swift
//  trader
//
//  Created by Svyatoslav Katola on 09.06.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import Foundation

public struct OrderBook: Decodable {
    public struct Order: Decodable {
        public let quantity: Double
        public let rate: Double
        
        public enum CodingKeys: String, CodingKey {
            case quantity = "Quantity"
            case rate = "Rate"
        }
    }
    
    public let buy: [Order]
    public let sell: [Order]
}
