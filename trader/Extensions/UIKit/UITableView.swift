//
//  UITableView.swift
//  trader
//
//  Created by Svyatoslav Katola on 24.05.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import UIKit

extension UITableView {
    
    func dequeueReusableCell<Cell: UITableViewCell>(withIdentifier identifier: String = .init(describing: Cell.self), for indexPath: IndexPath) -> Cell {
        guard let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? Cell else {
            fatalError("Could not dequeue \(Cell.self) from \(self)")
        }
        
        return cell
    }
}
