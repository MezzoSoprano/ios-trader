//
//  Localization.swift
//  safeline
//
//  Created by Svyatoslav Katola on 19.03.2020.
//  Copyright © 2020 Teamvoy. All rights reserved.
//

import Foundation

typealias Localization = L10n

extension Localization {
    
    struct Table {
        let name: String
        let bundle: Bundle
    }

    static func localized(_ key: String, table: Table) -> String {
        return NSLocalizedString(key, tableName: table.name,
                                 bundle: table.bundle, value: "", comment: "")
    }
}
