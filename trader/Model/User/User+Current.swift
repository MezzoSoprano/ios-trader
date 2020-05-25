//
//  User+Current.swift
//  trader
//
//  Created by Svyatoslav Katola on 26.05.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import FirebaseAuth

extension User {
    
    static var current: User? {
        return Auth.auth().currentUser
    }
}
