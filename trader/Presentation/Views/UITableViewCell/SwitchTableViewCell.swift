//
//  SwitchTableViewCell.swift
//  trader
//
//  Created by Svyatoslav Katola on 24.05.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import UIKit
import RxSwift

typealias Handler<T> = (T) -> Void

class SwitchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var `switch`: UISwitch!
    
    var onSwitch: Handler<UISwitch>?
}

extension SwitchTableViewCell {
    
    @IBAction func switched(_ sender: UISwitch) {
        onSwitch?(sender)
    }
}
