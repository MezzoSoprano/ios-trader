//
//  BuyViewController.swift
//  trader
//
//  Created by Svyatoslav Katola on 09.06.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import UIKit
import RxSwift
import Starscream
import SwiftyJSON

class BuyCryptoViewController: UIViewController {
    
    @IBOutlet weak var priceLabel: UITextField!
    @IBOutlet weak var amountLabel: UITextField!
    @IBOutlet weak var totalLabel: UITextField!
    
    @IBOutlet weak var ordersTableView: UITableView!
    
    @IBOutlet weak var selectFromButton: UIButton!
    @IBOutlet weak var selectToButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    var socket: WebSocket?
    
    override func viewWillDisappear(_ animated: Bool) {
        socket?.disconnect()
    }
    
    var accFrom: AccountBalance? {
        didSet { accFrom.map {
            selectFromButton.setTitle($0.asset, for: .normal)
            amountLabel.placeholder = " Max: \($0.free) \($0.asset)"
            } }
    }
    
    var accTo: AccountBalance? {
        didSet { accTo.map { selectToButton.setTitle($0.asset, for: .normal) } }
    }
    
    var amount: Double?
    var price: Double?
    
    var service: OrderService!
    var orders: [SocketOrder] = []
}

extension BuyCryptoViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as SocketOrderTableViewCell
        cell.configure(orders[indexPath.row])
        return cell
    }
    
    @IBAction func selectAccFrom(_ sender: UIButton) {
        let c = assembly.ui.currenciesFrom(selected: accFrom) { acc in
            self.accFrom = acc
            
            if let accc = self.accTo, let acccc = self.accFrom {
                self.socket?.disconnect()
                self.orders = []
                self.ordersTableView.reloadData()
                var request = URLRequest(url: URL(string: "wss://stream.binance.com:9443/ws/\(accc.asset+acccc.asset)@aggTrade")!)
                request.timeoutInterval = 5
                self.socket = WebSocket(request: request)
                self.socket?.delegate = self
                self.socket?.connect()
            }
            
            self.dismiss(animated: true)
        }
        
        present(c, animated: true)
    }
    
    @IBAction func selectAccTo(_ sender: UIButton) {
        let c = assembly.ui.currenciesTo(selected: accTo) { acc in
            self.accTo = acc
            
            if let accc = self.accTo, let acccc = self.accFrom {
                self.socket?.disconnect()
                self.orders = []
                self.ordersTableView.reloadData()
                var request = URLRequest(url: URL(string: "wss://stream.binance.com:9443/ws/\(accc.asset.lowercased()+acccc.asset.lowercased())@aggTrade")!)
                request.timeoutInterval = 5
                self.socket = WebSocket(request: request)
                self.socket?.delegate = self
                self.socket?.connect()
            }
            
            self.dismiss(animated: true)
        }
        
        present(c, animated: true)
    }
    
    @IBAction func createOrder(_ sender: Any) {
        guard let accountTo = accTo, let accountFrom = accFrom, let amount = amount, let price = price else {
            self.presentAlert(with: "Please configure all data !")
            return
        }
        
        service.placeOrder(accountTo: accountTo,
                           accountFrom: accountFrom,
                           amount: amount,
                           price: price)
            .subscribeOn(MainScheduler.asyncInstance)
            .subscribe(onSuccess: { _ in
                DispatchQueue.main.async { self.sucess() }
            }, onError: { err in
                DispatchQueue.main.async { self.presentAlert(with: err.localizedDescription) }
            })
            .disposed(by: rx.disposeBag)
    }
    
    func sucess() {
        let c = UIAlertController.init(title: "Succeded!", message: "Tour order was created!", preferredStyle: .alert)
        c.addAction(.init(title: "OK", style: .cancel, handler: { _ in self.navigationController?.popToRootViewController(animated: true) }))
        present(c, animated: true)
    }
}

extension BuyCryptoViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if textField == priceLabel {
            price = textField.text.flatMap { Double.init($0) }
        }
        
        if textField == amountLabel {
            amount = amountLabel.text.flatMap { Double.init($0) }
        }
        
        if let amount = amount, let price = price, let accTo = accTo {
            totalLabel.text = String(amount * price) + " \(accTo.asset)"
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension BuyCryptoViewController: WebSocketDelegate {
    
    func websocketDidConnect(socket: WebSocketClient) {
        print(#function)
        
//        subscribe(marketDepth: ["BNB_BTC.B-918"])
    }
    
    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        print(#function)
    }
    
    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        guard let textdata = text.data(using: .utf8, allowLossyConversion: false) else { return }
        guard let json = try? JSON(data: textdata) else { return }
        
        ordersTableView.beginUpdates()
        orders.insert(.init(json: json), at: 0)
        ordersTableView.insertRows(at: [.init(row: 0, section: 0)], with: .automatic)
        ordersTableView.endUpdates()
        
        print(text)
//        ordersTableView.reloadData()
    }
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        print(String.init(data: data, encoding: .utf8))
        print(#function)
    }
}

enum Parameter: String {
    
    case topic
    case address
    case userAddress
    case symbols
}

struct Message {

    var method: Method = .subscribe
    var topic: String = ""
    var parameters: [Parameter: Any] = [:]

    init(method: Method, topic: String, parameters: [Parameter:Any]) {
        self.method = method
        self.topic = topic
        self.parameters = parameters
    }

    init(method: Method, topic: Topic, parameters: [Parameter:Any]) {
        self.init(method: method, topic: topic.rawValue, parameters: parameters)
    }

    var json: String {
        var message: [String: Any] = [:]
        message["method"] = self.method.rawValue
        message["topic"] = self.topic
        self.parameters.forEach({ message[$0.0.rawValue] = $0.1 })
        return JSON(message).rawString() ?? "{}"
    }
}

enum Topic: String {
    
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

internal enum Method: String {
    case subscribe = "subscribe"
    case unsubscribe = "unsubscribe"
}

public struct Subscription {
    internal var message: Message
}

public enum Symbols: String {
    case all = "$all"
}

