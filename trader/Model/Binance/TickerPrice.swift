//
//  BinanceAPI.swift
//  trader
//
//  Created by Svyatoslav Katola on 09.06.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import Foundation

public struct TickerPrice: Codable {
    public var symbol: String
    public var price: String
}
