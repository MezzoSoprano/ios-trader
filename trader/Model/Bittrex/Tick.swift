//
//  BinanceAPI.swift
//  trader
//
//  Created by Svyatoslav Katola on 09.06.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import Foundation

public struct Tick: Decodable {
    public let bid: Double
    public let ask: Double
    public let last: Double
    
    public enum CodingKeys: String, CodingKey {
        case bid = "Bid"
        case ask = "Ask"
        case last = "Last"
    }
}
