//
//  ExchangesViewController.swift
//  trader
//
//  Created by Svyatoslav Katola on 25.05.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import UIKit
import RxSwift

class ExchangesViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = .init(frame: .zero)
        
        exchangeService
            .availableExchanges()
            .map { $0.map(Exchange.init).compactMap { $0 } }
            .subscribe(onSuccess: { [weak self] in
                self?.exchanges = $0
                self?.tableView.reloadData()
            })
            .disposed(by: rx.disposeBag)
    }
    
    var onSelect: Handler<Exchange>?
    var exchanges: [Exchange] = []
    var exchangeService: ExchangeService!
}

extension ExchangesViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exchanges.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath)
        cell.textLabel?.text = exchanges[indexPath.row].rawValue
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = assembly.ui.linkExchange(exchange: exchanges[indexPath.row])
        present(controller, animated: true)
    }
}
