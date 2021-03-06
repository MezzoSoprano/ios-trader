//
//  BinanceAPI.swift
//  trader
//
//  Created by Svyatoslav Katola on 09.06.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

//import Result
import APIKit

public final class Bittrex {
    
    private let auth: AuthBittrex
    private let nonce: String
    
    public init(apiKey: String, apiSecret: String) {
        nonce = UUID().uuidString
        auth = AuthBittrex(apiKey: apiKey, apiSecret: apiSecret, nonce: nonce)
    }
}

// MARK: - Public Service

extension Bittrex {
    
    public func getMarkets(handler: @escaping (Result<GetMarketsResponse, APIKit.SessionTaskError>) -> Void) {
        let request = PublicService.GetMarkets()
        send(request, handler: handler)
    }
    
    public func getCurrencires(handler: @escaping (Result<GetCurrenciesResponse, APIKit.SessionTaskError>) -> Void) {
        let request = PublicService.GetCurrencies()
        send(request, handler: handler)
    }
    
    public func getTicker(market: String, handler: @escaping (Result<GetTickerResponse, APIKit.SessionTaskError>) -> Void) {
        let request = PublicService.GetTicker(market: market)
        send(request, handler: handler)
    }
    
    public func getMarketSummaries(handler: @escaping (Result<GetMarketSummariesResponse, APIKit.SessionTaskError>) -> Void) {
        let request = PublicService.GetMarketSummaries()
        send(request, handler: handler)
    }
    
    public func getMarketSummary(market: String, handler: @escaping (Result<GetMarketSummaryResponse, APIKit.SessionTaskError>) -> Void) {
        let request = PublicService.GetMarketSummary(market: market)
        send(request, handler: handler)
    }
    
    public func getOrderBook(market: String, handler: @escaping (Result<GetOrderBookResponse, APIKit.SessionTaskError>) -> Void) {
        let request = PublicService.GetOrderBook(market: market)
        send(request, handler: handler)
    }
    
    public func getSellOrders(market: String, handler: @escaping (Result<GetOrdersResponse, APIKit.SessionTaskError>) -> Void) {
        let request = PublicService.GetSellOrders(market: market)
        send(request, handler: handler)
    }
    
    public func getBuyOrders(market: String, handler: @escaping (Result<GetOrdersResponse, APIKit.SessionTaskError>) -> Void) {
        let request = PublicService.GetBuyOrders(market: market)
        send(request, handler: handler)
    }
    
    public func getMarketHistory(market: String, handler: @escaping (Result<GetMarketHistoryResponse, APIKit.SessionTaskError>) -> Void) {
        let request = PublicService.GetMarketHistory(market: market)
        send(request, handler: handler)
    }
}

// MARK: - Account Service

extension Bittrex {
    
    public func getBalances(handler: @escaping (Result<GetBalancesResponse, APIKit.SessionTaskError>) -> Void) {
        let request = AccountService.GetBalances()
        send(request, handler: handler)
    }
    
    public func getBalance(currency: String, handler: @escaping (Result<GetBalanceResponse, APIKit.SessionTaskError>) -> Void) {
        let request = AccountService.GetBalance(currency: currency)
        send(request, handler: handler)
    }
    
    public func getDepositAddress(currency: String, handler: @escaping (Result<GetDepositAddressResponse, APIKit.SessionTaskError>) -> Void) {
        let request = AccountService.GetDepositAddress(currency: currency)
        send(request, handler: handler)
    }
    
    public func withdraw(currency: String, quantity: Double, address: String, handler: @escaping (Result<WithdrawResponse, APIKit.SessionTaskError>) -> Void) {
        let request = AccountService.Withdraw(currency: currency, quantity: quantity, address: address)
        send(request, handler: handler)
    }
}

// MARK: - Market Service

extension Bittrex {
    
    public func buyLimit(market: String, quantity: Double, rate: Double, handler: @escaping (Result<BuySellLimitResponse, APIKit.SessionTaskError>) -> Void) {
        let request = MarketService.BuyLimit(market: market, quantity: quantity, rate: rate)
        send(request, handler: handler)
    }
    
    public func sellLimit(market: String, quantity: Double, rate: Double, handler: @escaping (Result<BuySellLimitResponse, APIKit.SessionTaskError>) -> Void) {
        let request = MarketService.SellLimit(market: market, quantity: quantity, rate: rate)
        send(request, handler: handler)
    }
    
    public func cancel(uuid: String, handler: @escaping (Result<CancelResponse, APIKit.SessionTaskError>) -> Void) {
        let request = MarketService.Cancel(uuid: uuid)
        send(request, handler: handler)
    }
    
    public func getOpenOrders(market: String, handler: @escaping (Result<GetOpenOrdersResponse, APIKit.SessionTaskError>) -> Void) {
        let request = MarketService.GetOpenOrders(market: market)
        send(request, handler: handler)
    }
}

extension Bittrex {
    
    public func send<Request: BittrexRequest>(_ request: Request, handler: @escaping (Result<Request.Response, APIKit.SessionTaskError>) -> Void) {
        let httpRequest = HTTPRequest(request, auth: auth, nonce: nonce)
        Session.shared.send(httpRequest, handler: handler)
    }
}

//class ExchangeAPI {
//    
//    let apiKey: String?
//    let apiSecret: String?
//}
