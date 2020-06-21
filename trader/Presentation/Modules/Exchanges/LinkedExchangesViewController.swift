//
//  LinkedExchangesTableViewController.swift
//  trader
//
//  Created by Svyatoslav Katola on 21.06.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import UIKit
import RxSwift

class LinkedExchangesViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = .init(frame: .zero)
        
        exchangeService
            .linkedExchanges()
            .observeOn(MainScheduler.asyncInstance)
            .subscribe(onSuccess: { [weak self] in
                self?.exchanges = $0.first.map {[$0]} ?? []
                self?.tableView.reloadData()
            })
            .disposed(by: rx.disposeBag)
    }
    
    var exchanges: [Exchange.Linked] = []
    var exchangeService: ExchangeService!
}

extension LinkedExchangesViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exchanges.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath)
        cell.textLabel?.text = exchanges[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let controller = assembly.ui.linkExchange(exchange: exchanges[indexPath.row])
//        present(controller, animated: true)
    }
}
