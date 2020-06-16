//
//  BinanceAPI.swift
//  trader
//
//  Created by Svyatoslav Katola on 09.06.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import Foundation

public struct MarketSummary: Decodable {
    public let marketName: String
    public let high: Double
    public let low: Double
    public let last: Double
    public let baseVolume: Double
    public let bid: Double
    public let ask: Double
    public let openBuyOrders: Int64
    public let openSellOrders: Int64
    public let previousDay: Double
    public let displayMarketName: String?
    
    public enum CodingKeys: String, CodingKey {
        case marketName = "MarketName"
        case high = "High"
        case low = "Low"
        case last = "Last"
        case baseVolume = "BaseVolume"
        case bid = "Bid"
        case ask = "Ask"
        case openBuyOrders = "OpenBuyOrders"
        case openSellOrders = "OpenSellOrders"
        case previousDay = "PrevDay"
        case displayMarketName = "DisplayMarketName"
    }
}
