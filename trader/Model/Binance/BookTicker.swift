//
//  BinanceAPI.swift
//  trader
//
//  Created by Svyatoslav Katola on 09.06.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//


import Foundation

public struct BookTicker: Codable {
    public var symbol: String
    public var bidPrice: String
    public var bidQuantity: String
    public var askPrice: String
    public var askQuantity: String

    private enum CodingKeys: String, CodingKey {
        case symbol, bidPrice, bidQuantity = "bidQty", askPrice, askQuantity = "askQty"
    }
}
