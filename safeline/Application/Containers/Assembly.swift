//
//  Assembly.swift
//  safeline
//
//  Created by Svyatoslav Katola on 19.03.2020.
//  Copyright © 2020 Teamvoy. All rights reserved.
//

import Dip

let assembly: Assembly = .init(ui: .ui(), services: .services(), core: .core())

struct Assembly {
    
    let core: CoreContainer
    let services: ServicesContainer
    let ui: UIContainer
    
    fileprivate init(ui: DependencyContainer, services: DependencyContainer, core: DependencyContainer) {
        self.core = core
        self.services = services
        self.ui = ui
        
        ui.collaborate(with: services)
        services.collaborate(with: core)
    }
}
