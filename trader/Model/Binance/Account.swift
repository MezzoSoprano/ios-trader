//
//  BinanceAPI.swift
//  trader
//
//  Created by Svyatoslav Katola on 09.06.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//


import Foundation

public struct Account: Codable {
    public var makerCommission: Int
    public var takerCommission: Int
    public var buyerCommission: Int
    public var sellerCommission: Int
    public var canTrade: Bool
    public var canWithdraw: Bool
    public var canDeposit: Bool
    public var updateTime: Int
    public var balances: [AccountBalance]
}

public struct AccountBalance: Codable {
    
    public var asset: String
    public var free: String
    public var locked: String
}
