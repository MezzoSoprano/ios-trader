//
//  SocketOrderTableViewCell.swift
//  trader
//
//  Created by Svyatoslav Katola on 09.06.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import UIKit
import SwiftyJSON

class SocketOrderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
}

extension SocketOrderTableViewCell {
    
    var formatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .full
        return formatter
    }
    
    func configure(_ order: SocketOrder) {
        self.amountLabel.text = order.amount
        self.priceLabel.text = order.price
        self.dateLabel.text = formatter.string(from: order.date)
        
        self.priceLabel.textColor = order.side == .buy ? .green : .red
    }
}

struct SocketOrder {
    
    let side: OrderSide
    let price: String
    let amount: String
    let date: Date
    
    init(from: Order) {
        self.side = from.side
        self.price = from.price
        self.amount = from.originalQuantity
        self.date = Date()
    }
    
    init(json: JSON) {
        self.side = json["m"].bool == false ? .buy : .sell
        self.price = json["p"].string ?? ""
        self.amount = json["q"].string ?? ""
        self.date = Date()
    }
}
