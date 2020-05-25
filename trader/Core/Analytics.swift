//
//  Analytics.swift
//  trader
//
//  Created by Svyatoslav Katola on 17.03.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import Firebase
import Logging

protocol AnalyticsService {
    
    static func setup()
}

enum Analytics: AnalyticsService {
    
    static func setup() {
        services.forEach { $0.setup() }
    }
    
    static let services: [AnalyticsService.Type] = [Logger.self, FirebaseApp.self]
}

// MARK: - Firebase

extension FirebaseApp: AnalyticsService {
    
    static func setup() {
        FirebaseApp.configure()
    }
}

// MARK: - Logger

extension Logger: AnalyticsService {
    
    static func setup() { }
}
