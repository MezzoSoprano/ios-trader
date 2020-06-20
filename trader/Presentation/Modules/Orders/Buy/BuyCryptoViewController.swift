//
//  BuyViewController.swift
//  trader
//
//  Created by Svyatoslav Katola on 09.06.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import UIKit

class BuyCryptoViewController: UIViewController {
    
    @IBOutlet weak var priceLabel: UITextField!
    @IBOutlet weak var amountLabel: UITextField!
    @IBOutlet weak var totalLabel: UITextField!
    @IBOutlet weak var ordersTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        output.viewDidLoad()
    }
    
    var output: BuyCryptoViewOutput!
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
}

extension BuyCryptoViewController {
    
    @IBAction func selectCurrencyFrom() {
        output.selectCurrencyFrom()
    }
    
    @IBAction func selectCurrencyTo() {
        output.selectCurrencyTo()
    }
    
    @IBAction func priceLabelDidChangeEditing() {
        guard let price = priceLabel.text.flatMap(Double.init) else { return }
        output.priceDidChange(price: price)
    }
    
    @IBAction func amountLabelDidChangeEditing() {
        guard let amount = amountLabel.text.flatMap(Double.init) else { return }
        output.amountDidChange(amount: amount)
    }
}

extension BuyCryptoViewController: BuyCryptoViewInput {
    
    func configure(with new: [Order]) {
        orders.append(contentsOf: new.map(SocketOrder.init))
        ordersTableView.reloadData()
    }
    
//    func configure(with error: Error) {
//        let alert: UIAlertController = .init(title: "Error happend while procceding", message: error.localizedDescription, preferredStyle: .alert)
//        present(alert, animated: true)
//    }s
    
    func configureWithSuccess() {
        let alert: UIAlertController = .init(title: "Succed!",
                                             message: "New Order was created!",
                                             preferredStyle: .alert)
        present(alert, animated: true)
    }
}

extension UIViewController {
    
    func configure(with error: Error) {
        let alert: UIAlertController = .init(title: "Error happend while procceding", message: error.localizedDescription, preferredStyle: .alert)
        present(alert, animated: true)
    }
}
