//
//  SwitchTableViewCell.swift
//  trader
//
//  Created by Svyatoslav Katola on 24.05.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import UIKit

final class AvailableAmountView: AmountView {
    
    @IBOutlet weak var availableAmountButton: UIButton!
    
    @IBAction func tapAmount(_ sender: Any) {
        textField.delegate?.textFieldDidEndEditing?(textField)
    }
}
