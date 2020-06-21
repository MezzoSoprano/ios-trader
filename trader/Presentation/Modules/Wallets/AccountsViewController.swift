//
//  AccountsViewController.swift
//  trader
//
//  Created by Svyatoslav Katola on 21.06.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import UIKit
import RxSwift

class AccountsViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = .init(frame: .zero)
        
        walletService
            .accounts(exchange: .binance)
            .observeOn(MainScheduler.asyncInstance)
            .subscribe(onSuccess: { [weak self] in
                self?.balances = $0
                self?.tableView.reloadData()
            })
            .disposed(by: rx.disposeBag)
    }
    
    var onSelect: Handler<Exchange>?
    var balances: [AccountBalance] = []
    var walletService: WalletService!
}

extension AccountsViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return balances.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath)
        cell.textLabel?.text = balances[indexPath.row].asset
        cell.detailTextLabel?.text = balances[indexPath.row].free
        
        if let acc = Double(balances[indexPath.row].free) {
            cell.detailTextLabel?.textColor = acc > 0 ? .green : .red
            if acc == 0 { cell.detailTextLabel?.textColor = .gray }
        }
        
        return cell
    }
}
