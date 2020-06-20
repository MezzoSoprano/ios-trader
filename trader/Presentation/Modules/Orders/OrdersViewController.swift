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
            .subscribe(onSuccess: { self.orders = $0; self.tableView.reloadData(); self.finishLoading() },
                       onError: { print($0); self.finishLoading() })
            .disposed(by: rx.disposeBag)
    }
    
    var orderService: OrderService!
    var orders: [Order] = []
    
    lazy var activityIndicator = UIActivityIndicatorView()
}

extension OrdersViewController {
    
    @IBAction func add(_ sender: Any) {
//        let controller = assembly.ui
    }
    
    @IBAction func refresh(_ sender: UIRefreshControl) {
        orderService
            .all()
            .observeOn(MainScheduler.asyncInstance)
            .subscribe(onSuccess: { self.orders = $0; self.tableView.reloadData(); sender.endRefreshing() },
                       onError: { print($0); self.finishLoading() })
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
