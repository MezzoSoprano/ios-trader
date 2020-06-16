//
//  BuyViewController.swift
//  trader
//
//  Created by Svyatoslav Katola on 09.06.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import UIKit

class BuyViewController: UIViewController {
    
    @IBOutlet weak var priceLabel: UITextField!
    @IBOutlet weak var amountLabel: UITextField!
    @IBOutlet weak var totalLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    let orders: [SocketOrder] = [
        .init(side: .buy, price: "9,718.76", amount: "0.240001", date: "23:22:15"),
        .init(side: .buy, price: "9,718.24", amount: "0.000040", date: "23:22:15"),
        .init(side: .buy, price: "9,718.54", amount: "0.056232", date: "23:22:15"),
        .init(side: .sell, price: "9,718.21", amount: "0.754651", date: "23:22:16"),
        .init(side: .buy, price: "9,712.54", amount: "0.818454", date: "23:22:16"),
        .init(side: .sell, price: "9,713.72", amount: "0.046234", date: "23:22:16"),
        .init(side: .sell, price: "9,708.26", amount: "0.003214", date: "23:22:17"),
        .init(side: .sell, price: "9,706.28", amount: "0.111111", date: "23:22:20"),
        .init(side: .buy, price: "9,700.10", amount: "0.000012", date: "23:22:20"),
        .init(side: .buy, price: "9,700.21", amount: "0.435123", date: "23:22:20")
    ]
}

extension BuyViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as SocketOrderTableViewCell
        cell.configure(orders[indexPath.row])
        return cell
    }
}
