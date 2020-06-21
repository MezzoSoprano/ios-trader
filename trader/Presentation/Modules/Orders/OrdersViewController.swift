//
//  OrdersViewController.swift
//  trader
//
//  Created by Svyatoslav Katola on 09.06.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import UIKit
import RxSwift

class OrdersViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = .init()
        startLoading()
        orderService
            .all()
            .observeOn(MainScheduler.asyncInstance)
            .subscribe(onSuccess: { self.orders = $0.sorted { a, b in a.time > b.time }; self.tableView.reloadData(); self.finishLoading() },
                       onError: { print($0); self.finishLoading() })
            .disposed(by: rx.disposeBag)
    }
    
    var orderService: OrderService!
    var orders: [Order] = []
    
    lazy var activityIndicator = UIActivityIndicatorView()
}

extension OrdersViewController {
    
    @IBAction func add(_ sender: Any) {
        let controller = assembly.ui.buy()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func refresh(_ sender: Any) {
        orderService
            .all()
            .observeOn(MainScheduler.asyncInstance)
            .subscribe(onSuccess: { self.orders = $0.sorted { a, b in a.time > b.time }; self.tableView.reloadData(); self.tableView.refreshControl?.endRefreshing() },
                       onError: { print($0); self.finishLoading(); self.tableView.refreshControl?.endRefreshing() })
            .disposed(by: rx.disposeBag)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "BINANCE"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as OrderTableViewCell
        cell.configure(with: orders[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return self.orders[indexPath.row].status == .new
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Cancel") { _, _  in
            self.orderService.remove(order: self.orders[indexPath.row])
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.refresh(())
            }
        }

        return [deleteAction]
    }
    
    func startLoading() {
        activityIndicator.style = .large
        activityIndicator.frame = self.view.frame
        self.view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    func finishLoading() {
        activityIndicator.stopAnimating()
    }
}
