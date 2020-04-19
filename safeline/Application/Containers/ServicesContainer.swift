//
//  ServicesContainer.swift
//  safeline
//
//  Created by Svyatoslav Katola on 19.03.2020.
//  Copyright © 2020 Teamvoy. All rights reserved.
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
        return .init()
    }
}
