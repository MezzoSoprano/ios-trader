//
//  SwitchTableViewCell.swift
//  trader
//
//  Created by Svyatoslav Katola on 24.05.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import UIKit

final class CurrencyView: UIView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var optionLabel: UILabel!

    func configure(title: String, text: String? = nil, optionText: String? = nil) {
        isHidden = text == nil
        titleLabel.text = title
        textLabel.text = text
        optionLabel.isHidden = optionText == nil
        optionLabel.text = optionText
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
