import Foundation
import Starscream
import SwiftyJSON
import SwiftDate

public protocol WebSocketDelegate {
    
    func webSocketDidConnect(webSocket: WebSocket)
    func webSocketDidDisconnect(webSocket: WebSocket)
    func webSocketDidFail(webSocket: WebSocket, with error: Error)
    func webSocket(webSocket: WebSocket, orders: [Order])
    func webSocket(webSocket: WebSocket, account: Account)
    func webSocket(webSocket: WebSocket, trades: [Trade])
    func webSocket(webSocket: WebSocket, marketDiff: MarketDepthUpdate)
    func webSocket(webSocket: WebSocket, marketDepth: MarketDepthUpdate)
    func webSocket(webSocket: WebSocket, candlestick: Candlestick)
    func webSocket(webSocket: WebSocket, blockHeight: Int)
}

public class WebSocket {
    
    public enum Endpoint: String {
        case mainnet = "wss://dex.binance.org/api/ws"
        case testnet = "wss://testnet-dex.binance.org/api/ws"
    }
    
    public struct Subscription {
        internal var message: Message
    }
    
    public var delegate: WebSocketDelegate!
    
    internal enum Method: String {
        case subscribe = "subscribe"
        case unsubscribe = "unsubscribe"
    }
    
    internal enum Topic: String {
        case orders = "orders"
        case accounts = "accounts"
        case transfers = "transfers"
        case trades = "trades"
        case marketDiff = "marketDiff"
        case marketDepth = "marketDepth"
        case kline = "kline_%@"
        case ticker = "ticker"
        case allTickers = "allTickers"
        case miniTicker = "miniTicker"
        case allMiniTickers = "allMiniTickers"
        case blockHeight = "blockheight"
    }
    
    internal enum Parameter: String {
        case topic = "topic"
        case address = "address"
        case userAddress = "userAddress"
        case symbols = "symbols"
    }
    
    public enum Symbols: String {
        case all = "$all"
    }
    
    internal struct Message {
        
        var method: Method = .subscribe
        var topic: String = ""
        var parameters: [Parameter:Any] = [:]
        
        init(method: Method, topic: String, parameters: [Parameter:Any]) {
            self.method = method
            self.topic = topic
            self.parameters = parameters
        }
        
        init(method: Method, topic: Topic, parameters: [Parameter:Any]) {
            self.init(method: method, topic: topic.rawValue, parameters: parameters)
        }
        
        var json: String {
            var message: [String:Any] = [:]
            message["method"] = self.method.rawValue
            message["topic"] = self.topic
            self.parameters.forEach({ message[$0.0.rawValue] = $0.1 })
            return JSON(message).rawString() ?? "{}"
        }
        
    }
    
    private var socket: Starscream.WebSocket!
    
    private typealias Completed = (()->())
    
    private var connectCompleted: Completed?
    
    public init(delegate: WebSocketDelegate, endpoint: Endpoint = .testnet) {
        self.delegate = delegate
        
        guard let url = URL(string: endpoint.rawValue) else { return }
        self.socket = Starscream.WebSocket(url: url)
        self.socket.onConnect = { self.onConnect() }
        //        self.socket.onText = { (text: String) in self.onText(text: text) }
        self.socket.onDisconnect = { (error: Error?) in self.onDisconnect() }
        
    }
    
    public func connect(endpoint: Endpoint = .testnet, completion: @escaping ()->()) {
        self.connectCompleted = completion
        self.socket.connect()
    }
    
    public func disconnect() {
        self.socket.disconnect()
    }
    
    private func send(message: Message) -> Subscription {
        self.socket.write(string: message.json)
        return Subscription(message: message)
    }
    
    // MARK: - Subscribe
    
    @discardableResult
    public func subscribe(orders address: String) -> Subscription {
        let message = Message(method: .subscribe, topic: .orders, parameters: [.address: address, .userAddress: address])
        return self.send(message: message)
    }
    
    @discardableResult
    public func subscribe(accounts address: String) -> Subscription {
        let message = Message(method: .subscribe, topic: .accounts, parameters: [.address: address, .userAddress: address])
        return self.send(message: message)
    }
    
    @discardableResult
    public func subscribe(transfer address: String) -> Subscription {
        let message = Message(method: .subscribe, topic: .transfers, parameters: [.address: address, .userAddress: address])
        return self.send(message: message)
    }
    
    @discardableResult
    public func subscribe(trades symbols: [String]) -> Subscription {
        let message = Message(method: .subscribe, topic: .trades, parameters: [.symbols: symbols])
        return self.send(message: message)
    }
    
    @discardableResult
    public func subscribe(marketDiff symbols: [String]) -> Subscription {
        let message = Message(method: .subscribe, topic: .marketDiff, parameters: [.symbols: symbols])
        return self.send(message: message)
    }
    
    @discardableResult
    public func subscribe(marketDepth symbols: [String]) -> Subscription {
        let message = Message(method: .subscribe, topic: .marketDepth, parameters: [.symbols: symbols])
        return self.send(message: message)
    }
    
    //    @discardableResult
    //    public func subscribe(candlestick symbols: [String], interval: Interval) -> Subscription {
    //        let topic = String(format: Topic.kline.rawValue, interval.rawValue)
    //        let message = Message(method: .subscribe, topic: topic, parameters: [.symbols: symbols])
    //        return self.send(message: message)
    //    }
    
    @discardableResult
    public func subscribe(ticker symbols: [String]) -> Subscription {
        let message = Message(method: .subscribe, topic: .ticker, parameters: [.symbols: symbols])
        return self.send(message: message)
    }
    
    @discardableResult
    public func subscribe(ticker symbols: Symbols) -> Subscription {
        let message = Message(method: .subscribe, topic: .allTickers, parameters: [.symbols: [symbols.rawValue]])
        return self.send(message: message)
    }
    
    @discardableResult
    public func subscribe(miniTicker symbols: [String]) -> Subscription {
        let message = Message(method: .subscribe, topic: .miniTicker, parameters: [.symbols: symbols])
        return self.send(message: message)
    }
    
    @discardableResult
    public func subscribe(miniTicker symbols: Symbols) -> Subscription {
        let message = Message(method: .subscribe, topic: .allMiniTickers, parameters: [.symbols: [symbols.rawValue]])
        return self.send(message: message)
    }
    
    @discardableResult
    public func subscribe(blockheight symbols: Symbols) -> Subscription {
        let message = Message(method: .subscribe, topic: .blockHeight, parameters: [.symbols: [symbols.rawValue]])
        return self.send(message: message)
    }
    
    // MARK: - Unsubscribe
    
    public func unsubscribe(subscription: Subscription) {
        var message = subscription.message
        message.method = .unsubscribe
        _ = self.send(message: message)
    }
    
    // MARK: - Starscream
    
    private func onConnect() {
        if let completion = self.connectCompleted { completion() }
        self.connectCompleted = nil
        self.delegate.webSocketDidConnect(webSocket: self)
    }
    
    private func onDisconnect() {
        self.delegate.webSocketDidConnect(webSocket: self)
    }
    
    private func parse(val: JSON) {
        
    }
    
    private func onText(text: String) {
        
        DispatchQueue.global(qos: .background).async {
            
            do {
                guard let textdata = text.data(using: .utf8, allowLossyConversion: false) else { return }
                let json = try JSON(data: textdata)
                if let reason = json["error"]["error"].string {
                    DispatchQueue.main.async { self.delegate.webSocketDidFail(webSocket: self, with: BinanceError(message: reason)) }
                    return
                }
                guard let stream = Topic(rawValue: json["stream"].stringValue) else { return }
                let data = json["data"]
                
                let response = BinanceChain.Response()
                switch (stream) {
                case .orders:
                    try OrderParser().parse(data, response: response)
                    DispatchQueue.main.async { self.delegate.webSocket(webSocket: self, orders: response.orders) }
                    
                default:
                    break
                }
                
            } catch let error {
                
                DispatchQueue.main.async {
                    self.delegate.webSocketDidFail(webSocket: self, with: error)
                }
                
            }
            
        }
        
    }
    
}

public class MarketDepthUpdate {
    
    public var symbol: String = ""
    public var depth: MarketDepth = MarketDepth()
}

public class BinanceError: Error, LocalizedError {
    
    public enum Reason: Int {
        case unknown = 0
        init(_ code: Int) {
            self = .unknown
        }
    }
    
    public var code: Int = 0
    public var reason: Reason = .unknown
    private var message: String = ""
    
    required init(_ reason: Reason, message: String) {
        self.reason = reason
        self.message = message
    }
    
    convenience init(code: Int, message: String) {
        self.init(Reason(code), message: message)
        self.code = code
    }
    
    convenience init(message: String) {
        self.init(.unknown, message: message)
    }
    
    // MARK: - Error
    
    public var errorDescription: String? {
        return self.message
    }
    
}

public class BinanceChain {
    
    public class Response {
        public var isError: Bool = false
        public var error: Error?
        public var sequence: Int = 0
        public var blockHeight: Int = 0
        public var orders: [Order] = []
        public var trades: [Trade] = []
        public var markets: [Market] = []
        public var candlesticks: [Candlestick] = []
        public var marketDepth: MarketDepth = MarketDepth()
        public var marketDepthUpdate: MarketDepthUpdate = MarketDepthUpdate()
    }
}
    
class OrderParser {
    
    func parse(_ json: JSON, response: BinanceChain.Response) throws {
        response.orders = try self.parseOrder(json)
    }
    
    func parseOrder(_ json: JSON) throws -> [Order] {
        var order = Order()
        order.executedQuantity = json["cumulateQuantity"].string ?? json["z"].stringValue
        let orderCreateTimeValue = json["orderCreateTime"].string ?? json["O"].stringValue
        let transactionTimeValue = json["transactionTime"].string ?? json["T"].stringValue
        guard let orderCreateTime = orderCreateTimeValue.toDate()?.date else { throw ParseError(model: "Order", property: "orderCreateTime") }
        guard let transactionTime = transactionTimeValue.toDate()?.date else { throw ParseError(model: "Order", property: "transactionTime") }
        order.time = Int(orderCreateTime.timeIntervalSinceNow)
        order.timeInForce = nil
        return [order]
    }
}

struct ParseError: Error, LocalizedError {

    var model: String = ""
    var property: String = ""
    
    public var errorDescription: String? {
        guard (!self.property.isEmpty) else { return "Invalid response" }
        return String(format: "Invalid response (%@:%@)", model, property)
    }

}
