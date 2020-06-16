//
//  SwitchTableViewCell.swift
//  trader
//
//  Created by Svyatoslav Katola on 24.05.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import UIKit

final class PickerView: UIView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    func configure(title: String, text: String? = "", placeholder: String? = "") {
        titleLabel.text = title
        textField.text = text
        textField.placeholder = placeholder
    }
    
    func configure(text: String? = "", placeholder: String? = "") {
        textField.text = text
        textField.placeholder = placeholder
    }
    
    override var tintColor: UIColor! {
        didSet {
            titleLabel?.textColor = tintColor
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        sizeToFit()
        layoutIfNeeded()
    }
}
