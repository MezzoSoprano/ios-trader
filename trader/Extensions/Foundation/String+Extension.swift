//
//  String+Extension.swift
//  trader
//
//  Created by Svyatoslav Katola on 09.06.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import CryptoSwift

extension String {

    func hmac(secret: String, variant: HMAC.Variant = .sha256) -> String? {
        do {
            let hmac = try HMAC(key: secret, variant: variant)
            let result = try hmac.authenticate([UInt8](self.utf8))
            let hex = result.map { String(format: "%02x", $0) }.joined()
            return hex
        } catch {
            print(error)
        }

        return nil
    }
}
