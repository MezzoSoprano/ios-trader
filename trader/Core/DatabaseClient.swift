//
//  DatabaseClient.swift
//  trader
//
//  Created by Svyatoslav Katola on 25.05.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import FirebaseDatabase
import RxSwift
import SwiftyJSON

typealias KeyedDictionary = [String : AnyObject]

protocol DatabaseClient {
    
    func get<T: Codable>(route: Route) -> Single<T>
    func update<T: Codable>(route: Route, id: String, value: T) -> Single<T>
    func oberve(route: Route) -> Observable<KeyedDictionary>
}

enum Route: String {
    
    case users, transactions, exchanges = "available_exchanges"
}

final class FirebaseDatabaseClient {
    
    let database: DatabaseReference
    
    init(database: DatabaseReference) {
        self.database = database
    }
}

extension FirebaseDatabaseClient: DatabaseClient {
    
    func oberve(route: Route) -> Observable<[String : AnyObject]> {
        return Observable.create { [weak self] observer in
            _ = self?.database.child(route.rawValue).observe(.value) { snap in
                (snap.value as? KeyedDictionary).map {
                    observer.onNext($0)
                }
            }
            
            return Disposables.create()
        }
    }
    
    func get<T>(route: Route) -> Single<T> where T : Codable {
        return Single.create { [weak self] observer in
            self?.database.child(route.rawValue).observeSingleEvent(of: .value, with: { snap in
                
                (snap.value as? T).map {
                    observer(.success($0))
                }
            })
            
            return Disposables.create()
        }
    }
    
    func update<T>(route: Route, id: String, value: T) -> Single<T> where T : Codable {
        guard let dict = value.dictionary else { fatalError() }
        
        return Single.create { [weak self] observer in
            self?.database.child(route.rawValue).child(id).updateChildValues(dict) { err, ref in
                err.map { observer(.error($0)) }
                observer(.success(value))
            }
            
            return Disposables.create()
        }
    }
}

extension Encodable {
    
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}
