//
//  SettingsViewModel.swift
//  trader
//
//  Created by Svyatoslav Katola on 24.05.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import Foundation

enum Settings: String {
    case profile = "Profile"
    case advanced = "Other"
    
    init(index: Int) {
        switch index {
        case 0:
            self = .profile
        default:
            self = .advanced
        }
    }
    
    var items: [SettingsItemViewModel] {
        return self == .profile ? [.profile, .faceId] : [.privacyPolicy, .rateUs, .signOut]
    }
    
    static var all: [Settings] = [.advanced, .profile]
}

enum SettingsItemViewModel: String {
    
    case
    profile = "Profile description",
    faceId = "Enable Face ID",
    signOut = "Sign Out",
    rateUs = "Rate us",
    privacyPolicy = "Privacy Policy"
}
