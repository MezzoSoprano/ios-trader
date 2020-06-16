//
//  BinanceAPI.swift
//  trader
//
//  Created by Svyatoslav Katola on 09.06.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//


import Foundation

public enum OrderResponseType: String, Codable {
    case ack = "ACK", result = "RESULT", full = "FULL"
}

public enum OrderSide: String, Codable {
    case buy = "BUY", sell = "SELL"
}

public enum TimeInForce: String, Codable {
    case gtc = "GTC", ioc = "IOC", fok = "FOK"
}

public enum OrderType: String, Codable {
    case limit = "LIMIT"
    case market = "MARKET"
    case stopLoss = "STOP_LOSS"
    case stopLossLimit = "STOP_LOSS_LIMIT"
    case takeProfit = "TAKE_PROFIT"
    case takeProfitLimit = "TAKE_PROFIT_LIMIT"
    case limitMaker = "LIMIT_MAKER"
}

public enum OrderStatus: String, Codable {
    case new = "NEW"
    case partiallyFilled = "PARTIALLY_FILLED"
    case filled = "FILLED"
    case canceled = "CANCELED"
    case pendingCancel = "PENDING_CANCEL"
    case rejected = "REJECTED"
    case expired = "EXPIRED"
}

public struct OrderResponse: Codable {
    // ACK
    public var symbol: String
    public var orderId: Int
    public var clientOrderId: String
    public var transactTime: Int
    
    // RESULT
    public var price: String?
    public var origQty: String?
    public var executedQty: String?
    public var status: OrderStatus?
    public var timeInForce: TimeInForce?
    public var type: OrderType?
    public var side: OrderSide?
    
    // FULL
    public var fills: [OrderFill]?
}

public struct OrderFill: Codable {
    public var price: String
    public var quantity: String
    public var commission: String
    public var commissionAsset: String
    
    private enum CodingKeys: String, CodingKey {
        case price, quantity = "qty", commission, commissionAsset
    }
}

public struct Order: Codable {
    
    public var symbol: String
    public var orderId: Int
    public var clientOrderId: String
    public var price: String
    public var originalQuantity: String
    public var executedQuantity: String
    public var status: OrderStatus
    public var timeInForce: TimeInForce?
    public var type: OrderType
    public var side: OrderSide
    public var stopPrice: String
    public var icebergQuantity: String
    public var time: Int
    public var isWorking: Bool
    
    
    init() {
        self.symbol = ""
        self.orderId = 1
        self.clientOrderId = ""
        self.price = ""
        self.originalQuantity = ""
        self.executedQuantity = ""
        self.status = .canceled
        self.timeInForce = nil
        self.type = .limit
        self.side = .sell
        self.stopPrice = ""
        self.icebergQuantity = ""
        self.time = .min
        self.isWorking = false
    }
    
    private enum CodingKeys: String, CodingKey {
        case symbol
        case orderId
        case clientOrderId
        case price
        case originalQuantity = "origQty"
        case executedQuantity = "executedQty"
        case status
        case timeInForce
        case type
        case side
        case stopPrice
        case icebergQuantity = "icebergQty"
        case time
        case isWorking
    }
    
    var formattedQuantity: Double? {
        return Double(originalQuantity)
    }
    
    var formattedPrice: Double? {
        return Double(price)
    }
}

public struct CancelledOrder: Codable {
    
    public var symbol: String
    public var origClientOrderId: String
    public var orderId: Int
    public var clientOrderId: String
}
