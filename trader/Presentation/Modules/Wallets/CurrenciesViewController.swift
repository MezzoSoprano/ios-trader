//
//  TableViewController.swift
//  trader
//
//  Created by Svyatoslav Katola on 16.06.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import UIKit
import RxSwift

class Currencies<Element>: UITableViewController where Element: Equatable & CustomStringConvertible {
    
    typealias Elements = [Element]
    typealias OnSelect = (Element) -> Void
    typealias Request = Single<Elements>
    
    private var elements = Elements()
    var selected: Element?
    var onSelect: OnSelect?
    var request: Request!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        
        request?
            .observeOn(MainScheduler.asyncInstance)
            .do(
                onSuccess: { [weak self] in
                    self?.elements = $0
                    self?.tableView.reloadData()
                }
            )
            .subscribe()
            .disposed(by: rx.disposeBag)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath)
        let element = elements[indexPath.row]
        cell.textLabel?.text = element.description
        cell.accessoryType = element == selected ? .checkmark : .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onSelect?(elements[indexPath.row])
    }
    
    func element(at: IndexPath) -> Element {
        return elements[at.row]
    }
}

final class CurrenciesFromViewController: Currencies<AccountBalance> { }
final class CurrenciesToViewController: Currencies<AccountBalance> { }
