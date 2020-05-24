//
//  ProfileViewController.swift
//  trader
//
//  Created by Svyatoslav Katola on 24.05.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = .init(frame: .zero)
    }
    
    var authService: AuthService!
}

extension SettingsViewController {
    
    func signOut() {
        authService
            .signOut()
            .subscribe(onError: { [weak self] in self?.presentAlert(with: $0.localizedDescription) })
            .disposed(by: rx.disposeBag)
    }
}

extension SettingsViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        Settings.all.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Settings.init(index: section).rawValue
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Settings.init(index: section).items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = Settings.init(index: indexPath.section).items[indexPath.row]
        
        switch item {
        case .faceId:
            let cell = tableView.dequeueReusableCell(for: indexPath) as SwitchTableViewCell
            cell.label.text = item.rawValue
            return cell
        default:
            let cell = tableView.dequeueReusableCell(for: indexPath)
            cell.textLabel?.text = item.rawValue
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Settings.item(for: indexPath) == .signOut ? signOut() : ()
    }
}
