//
//  AppDelegate.swift
//  trader
//
//  Created by Svyatoslav Katola on 17.03.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Analytics.setup()
        window?.rootViewController = assembly.ui.root()
        window?.overrideUserInterfaceStyle = .dark
        return true
    }
}
