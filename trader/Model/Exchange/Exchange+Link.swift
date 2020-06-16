//
//  Exchange+Link.swift
//  trader
//
//  Created by Svyatoslav Katola on 26.05.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import Foundation

extension Exchange {
    
    struct Link: Codable {
        
        let name: String
        let passsword: String
        let apiKey: String
        var secretKey: String
        let exchangeName: String
    }
}
