//
//  AuthServiceImpl.swift
//  trader
//
//  Created by Svyatoslav Katola on 24.05.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import RxSwift
import FirebaseAuth
import FirebaseDatabase

class AuthServiceImpl {
    
    let fauth: Auth
    let client: DatabaseClient
    
    init(fauth: Auth,
         client: DatabaseClient) {
        self.fauth = fauth
        self.client = client
    }
    
    private let disposeBag = DisposeBag()
}

extension AuthServiceImpl: AuthService {
    
    func sessionUpdates() -> Observable<User?> {
        return Observable.create { [unowned self] observer in
            let handler = self.fauth.addStateDidChangeListener { _, user in
                observer.onNext(user)
                user.map(self.saveToDatabase(user:))
            }
            
            return Disposables.create { self.fauth.removeStateDidChangeListener(handler) }
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
    
    private func saveToDatabase(user: User) {
        client.update(route: .users, id: user.uid, value: UserM(from: user))
            .subscribe()
            .disposed(by: disposeBag)
    }
}
