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
    
    let orders: [SocketOrder] = []
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
