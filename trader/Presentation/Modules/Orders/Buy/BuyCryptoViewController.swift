//
//  BuyViewController.swift
//  trader
//
//  Created by Svyatoslav Katola on 09.06.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import UIKit
import RxSwift

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
            self.dismiss(animated: true)
        }
        
        present(c, animated: true)
    }
    
    @IBAction func selectAccTo(_ sender: UIButton) {
        let c = assembly.ui.currenciesTo(selected: accTo) { acc in
            self.accTo = acc
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
            .subscribe(onSuccess: { _ in print("success")
            }, onError: { err in self.presentAlert(with: err.localizedDescription) })
            .disposed(by: rx.disposeBag)
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
