//
//  OrderTableViewCell.swift
//  trader
//
//  Created by Svyatoslav Katola on 09.06.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import UIKit

class OrderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var pairLabel: UILabel!
    @IBOutlet weak var sideLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
}

extension OrderTableViewCell {
    
    func configure(with order: Order) {
        self.quantityLabel.text = order.formattedQuantity.map { String(format: "%.4f", $0) }
        self.pairLabel.text = order.symbol
        self.sideLabel.text = order.side.rawValue
        self.sideLabel.textColor = order.side == .sell ? .red : .green
        self.priceLabel.text = order.formattedPrice.map { String(format: "%.2f", $0) }
        self.statusLabel.text = order.status.rawValue
        self.statusLabel.textColor = order.status == .new || order.status == .filled ? .green : .red
    }
}
