//
//  BinanceAPI.swift
//  trader
//
//  Created by Svyatoslav Katola on 09.06.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import APIKit

public final class MarketService {
    public struct BuyLimit: BittrexRequest {
        public typealias Response = BuySellLimitResponse
        
        public let market: String
        public let quantity: Double
        public let rate: Double
        
        public init(market: String, quantity: Double, rate: Double) {
            self.market = market
            self.quantity = quantity
            self.rate = rate
        }
        
        public var path: String {
            return "/market/buylimit"
        }
        
        public var parameters: Any? {
            return ["market": market, "quantity": quantity, "rate": rate]
        }
        
        public var withAuth: Bool {
            return true
        }
    }
    
    public struct SellLimit: BittrexRequest {
        public typealias Response = BuySellLimitResponse
        
        public let market: String
        public let quantity: Double
        public let rate: Double
        
        public init(market: String, quantity: Double, rate: Double) {
            self.market = market
            self.quantity = quantity
            self.rate = rate
        }
        
        public var path: String {
            return "/market/selllimit"
        }
        
        public var parameters: Any? {
            return ["market": market, "quantity": quantity, "rate": rate]
        }
        
        public var withAuth: Bool {
            return true
        }
    }
    
    public struct Cancel: BittrexRequest {
        public typealias Response = CancelResponse
        
        public let uuid: String
        
        public init(uuid: String) {
            self.uuid = uuid
        }
        
        public var path: String {
            return "/market/cancel"
        }
        
        public var parameters: Any? {
            return ["uuid": uuid]
        }
        
        public var withAuth: Bool {
            return true
        }
    }
    
    public struct GetOpenOrders: BittrexRequest {
        public typealias Response = GetOpenOrdersResponse
        
        public let market: String
        
        public init(market: String) {
            self.market = market
        }
        
        public var path: String {
            return "/market/getopenorders"
        }
        
        public var parameters: Any? {
            return ["market": market]
        }
        
        public var withAuth: Bool {
            return true
        }
    }
}

public struct BuySellLimitResponse: Decodable {
    
    public struct Response: Decodable {
        public let uuid: String
        
        public enum CodingKeys: String, CodingKey {
            case uuid
        }
    }
    
    public let message: String
    public let success: Bool
    public let uuid: String?
    
    public enum CodingKeys: String, CodingKey {
        case message
        case success
        case response = "result"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        message = try container.decode(String.self, forKey: .message)
        success = try container.decode(Bool.self, forKey: .success)
        
        let response = try container.decodeIfPresent(Response.self, forKey: .response)
        uuid = response?.uuid
    }
}

public struct GetOpenOrdersResponse: Decodable {
    public let message: String
    public let openOrders: [OpenOrder]
    public let success: Bool
    
    public enum CodingKeys: String, CodingKey {
        case message
        case openOrders = "result"
        case success
    }
}

public struct CancelResponse: Decodable {
    public let message: String
    public let success: Bool
}
