//
//  AuthService.swift
//  trader
//
//  Created by Svyatoslav Katola on 24.05.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import RxSwift
import FirebaseAuth

protocol AuthService {
    
    func signOut() -> Single<Void>
    func sessionUpdates() -> Observable<User?>
}
