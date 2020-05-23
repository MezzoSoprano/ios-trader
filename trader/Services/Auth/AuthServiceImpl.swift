//
//  AuthServiceImpl.swift
//  trader
//
//  Created by Svyatoslav Katola on 24.05.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import RxSwift
import FirebaseAuth

class AuthServiceImpl {
    let fauth: Auth

    init(fauth: Auth) {
        self.fauth = fauth
    }
}

extension AuthServiceImpl: AuthService {
    
    func sessionUpdates() -> Observable<User?> {
        return Observable.create { [weak self] observer in
            let handler = self?.fauth.addStateDidChangeListener { _, user in
                observer.onNext(user)
            }
            
            return Disposables.create { self?.fauth.removeStateDidChangeListener(handler!) }
        }
    }
    
    func signOut() -> Single<Void> {
        return Single.create { [weak self] observer in
            do {
                try self?.fauth.signOut()
            } catch {
                observer(.error(error))
            }
            
            observer(.success(()))
            return Disposables.create()
        }
    }
}
