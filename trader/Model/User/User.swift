//
//  User.swift
//  trader
//
//  Created by Svyatoslav Katola on 25.05.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import FirebaseAuth

struct UserM {
    
    let name: String?
    let email: String?
    let photoURL: URL?
    let emailVerified: Bool
}

extension UserM: Codable {
    
    init(from user: User) {
        self.email = user.email
        self.name = user.email
        self.photoURL = user.photoURL
        self.emailVerified = user.isEmailVerified
    }
}
