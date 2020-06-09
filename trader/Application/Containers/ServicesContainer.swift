//
//  ServicesContainer.swift
//  trader
//
//  Created by Svyatoslav Katola on 19.03.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import Dip

protocol ServicesContainer {
    
    func service<T>(_ type: T.Type) -> T
}

// swiftlint:disable force_try
extension DependencyContainer: ServicesContainer {
    
    func service<T>(_ type: T.Type) -> T {
        return try! resolve()
    }
}

extension DependencyContainer {
    
    static func services() -> DependencyContainer {
        let container = DependencyContainer()
        
        container.register(.singleton) { () -> AuthService in
            return AuthServiceImpl(fauth: try! container.resolve(),
                                   client: try! container.resolve())
        }
        
        container.register(.singleton) { () -> ExchangeService in
            return ExchangeServiceImpl(client: try! container.resolve(), ref: try! container.resolve())
        }
        
        container.register(.singleton) { () -> OrderService in
            return OrderServiceImpl(client: try! container.resolve())
        }
        
        return container
    }
}
