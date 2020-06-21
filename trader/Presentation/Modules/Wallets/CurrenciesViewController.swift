//
//  TableViewController.swift
//  trader
//
//  Created by Svyatoslav Katola on 16.06.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import UIKit
import RxSwift

class CurrenciesFromViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = .init(frame: .zero)
        
        walletService
            .activeAccounts(exchange: .binance, except: except)
            .observeOn(MainScheduler.asyncInstance)
            .subscribe(onSuccess: { [weak self] in
                self?.balances = $0
                self?.tableView.reloadData()
            })
            .disposed(by: rx.disposeBag)
    }
    
    var except: AccountBalance?
    var selected: AccountBalance?
    var onSelect: Handler<AccountBalance>?
    var balances: [AccountBalance] = []
    var walletService: WalletService!
}

extension CurrenciesFromViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return balances.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath)
        cell.textLabel?.text = balances[indexPath.row].asset
        cell.detailTextLabel?.text = balances[indexPath.row].free
        cell.accessoryType = balances[indexPath.row].asset == selected?.asset ? .checkmark : .none
        if let acc = Double(balances[indexPath.row].free) {
            cell.detailTextLabel?.textColor = acc > 0 ? .green : .red
            if acc == 0 { cell.detailTextLabel?.textColor = .gray }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onSelect?(balances[indexPath.row])
    }
}

class CurrenciesToViewController: UITableViewController {
    
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
    
    var selected: AccountBalance?
    var onSelect: Handler<AccountBalance>?
    var balances: [AccountBalance] = []
    var walletService: WalletService!
}

extension CurrenciesToViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return balances.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath)
        cell.textLabel?.text = balances[indexPath.row].asset
        cell.detailTextLabel?.text = balances[indexPath.row].free
        cell.accessoryType = balances[indexPath.row].asset == selected?.asset ? .checkmark : .none
        if let acc = Double(balances[indexPath.row].free) {
            cell.detailTextLabel?.textColor = acc > 0 ? .green : .red
            if acc == 0 { cell.detailTextLabel?.textColor = .gray }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onSelect?(balances[indexPath.row])
    }
}
