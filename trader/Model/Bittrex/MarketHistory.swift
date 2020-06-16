//
//  BinanceAPI.swift
//  trader
//
//  Created by Svyatoslav Katola on 09.06.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import Foundation

public struct MarketHistory: Decodable {
    public let id: Int64
    public let quantity: Double
    public let price: Double
    public let total: Double
    public let fillType: String
    public let orderType: String
    
    public enum CodingKeys: String, CodingKey {
        case id = "Id"
        case quantity = "Quantity"
        case price = "Price"
        case total = "Total"
        case fillType = "FillType"
        case orderType = "OrderType"
    }
}
