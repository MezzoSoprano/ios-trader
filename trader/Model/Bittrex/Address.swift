//
//  BinanceAPI.swift
//  trader
//
//  Created by Svyatoslav Katola on 09.06.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import Foundation

public struct Address: Decodable {
    public let currency: String
    public let address: String
    
    public enum CodingKeys: String, CodingKey {
        case currency = "Currency"
        case address = "Address"
    }
}
