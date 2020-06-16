//
//  SwitchTableViewCell.swift
//  trader
//
//  Created by Svyatoslav Katola on 24.05.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import UIKit

class AmountView: UIView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var optionLabel: UILabel!
    
    func configure(title: String, value: Decimal? = .none, placeholder: String? = "", optionText: String? = nil) {
        titleLabel.text = title
        textField.placeholder = placeholder
        optionLabel?.text = optionText
    }
    
    override var tintColor: UIColor! {
        didSet {
            titleLabel.textColor = tintColor
            optionLabel.textColor = tintColor
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        sizeToFit()
        layoutIfNeeded()
    }
}
