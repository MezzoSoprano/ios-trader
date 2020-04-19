//
//  Analytics.swift
//  trader
//
//  Created by Svyatoslav Katola on 17.03.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import Logging

protocol AnalyticsService {
    
    static func setup()
}

enum Analytics: AnalyticsService {
    
    static func setup() {
        services.forEach { $0.setup() }
    }
    
    #if DEBUG
    static let services: [AnalyticsService.Type] = [Logger.self]
    #else
    static let services: [AnalyticsService.Type] = []
    #endif
}

// MARK: - Logger

extension Logger: AnalyticsService {
    
    static func setup() { }
}
