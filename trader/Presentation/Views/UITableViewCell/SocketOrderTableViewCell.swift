//
//  SocketOrderTableViewCell.swift
//  trader
//
//  Created by Svyatoslav Katola on 09.06.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import UIKit

class SocketOrderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
}

extension SocketOrderTableViewCell {
    
    func configure(_ order: SocketOrder) {
        self.amountLabel.text = order.amount
        self.priceLabel.text = order.price
        self.dateLabel.text = order.date
        
        self.priceLabel.textColor = order.side == .buy ? .green : .red
    }
}

struct SocketOrder {
    
    let side: OrderSide
    let price: String
    let amount: String
    let date: String
}
