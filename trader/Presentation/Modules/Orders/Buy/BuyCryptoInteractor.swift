//
//  BuyCryptoInteractor.swift
//  trader
//
//  Created by Svyatoslav Katola on 16.06.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import Foundation
import RxSwift

class BuyCryptoInteractor {
    
    var service: TransferService!
//    var websocket: WebSocket!
    var output: BuyCryptoInteractorOutput!
    var exchange: Exchange!
    
    let disposeBag = DisposeBag()
}

extension BuyCryptoInteractor: BuyCryptoInteractorInput {
    
    func startWebSockets(symbol: String) {
//        let webSocket = WebSocket(delegate: self)
//        webSocket.connect {
//            webSocket.subscribe(orders: symbol)
//        }
    }
    
    func createOrder(market: String, quantity: Double, rate: Double) {
        switch exchange {
        case .binance:
            service.createBinanceOrder(market: market, quantity: quantity, rate: rate)
                .subscribe()
                .disposed(by: disposeBag)
        case .bittrex:
            service.createBinanceOrder(market: market, quantity: quantity, rate: rate)
                .subscribe()
                .disposed(by: disposeBag)
        case .none:
            break
        }
    }
}

//extension BuyCryptoInteractor: WebSocketDelegate {
//    
//    func webSocketDidConnect(webSocket: WebSocket) { }
//    
//    func webSocketDidDisconnect(webSocket: WebSocket) { }
//    
//    func webSocketDidFail(webSocket: WebSocket, with error: Error) {
//        output.error(error: error)
//    }
//    
//    func webSocket(webSocket: WebSocket, orders: [Order]) {
//        output.webScoketNew(orders: orders)
//    }
//    
//    func webSocket(webSocket: WebSocket, account: Account) { }
//    
//    func webSocket(webSocket: WebSocket, trades: [Trade]) { }
//    
//    func webSocket(webSocket: WebSocket, marketDiff: MarketDepthUpdate) { }
//
//    func webSocket(webSocket: WebSocket, marketDepth: MarketDepthUpdate) { }
//    
//    func webSocket(webSocket: WebSocket, candlestick: Candlestick) { }
//    
//    func webSocket(webSocket: WebSocket, blockHeight: Int) { }
//}
