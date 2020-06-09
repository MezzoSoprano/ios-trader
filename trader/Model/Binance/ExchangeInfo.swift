//
//  BinanceAPI.swift
//  trader
//
//  Created by Svyatoslav Katola on 09.06.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//


import Foundation

public struct ExchangeInfo: Codable {
    public var timezone: String
    public var serverTime: Int
    public var rateLimits: [RateLimit]
}

public enum RateLimitType: String, Codable {
    case requests = "REQUESTS"
    case orders = "ORDERS"
}

public enum RateLimitInterval: String, Codable {
    case second = "SECOND"
    case minute = "MINUTE"
    case day = "DAY"
}

public struct RateLimit: Codable {
    public var rateLimitType: RateLimitType
    public var interval: RateLimitInterval
    public var limit: Int
}
