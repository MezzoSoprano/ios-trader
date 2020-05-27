//
//  CommonCrypto.swift
//  trader
//
//  Created by Svyatoslav Katola on 27.05.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import CryptoKit

extension AES {
    
    func encrypt(text: String,
                 encoding: String.Encoding,
                 key: String,
                 symmetricKey: SymmetricKey) -> GCM.SealedBox {
        let keyData = key.data(using: encoding)!
        let textData = text.data(using: encoding)!
        
        return try! GCM.seal(textData, using: symmetricKey, authenticating: keyData)
    }
    
    func decrypt(box: GCM.SealedBox,
                 key: String,
                 encoding: String.Encoding,
                 symmetricKey: SymmetricKey) -> String {
        let keyData = key.data(using: encoding)!
        let decrypted = try! AES.GCM.open(box, using: symmetricKey, authenticating: keyData)
        
        return String(data: decrypted, encoding: .utf8)!
    }
}

//let pasword = "password".data(using: .utf8)
//let text = "text".data(using: .utf8)
//
////        let encrypted = try! AES.GCM.seal(text!, using: .init(data: pasword!))
//let key = SymmetricKey(size: .bits256)
//let encrypted = try! AES.GCM.seal(text!, using: key, authenticating: pasword!)
//let decrypted = try! AES.GCM.open(encrypted, using: key, authenticating: pasword!)
//
//_ = String.init(data: decrypted, encoding: .utf8).map { print($0) }
