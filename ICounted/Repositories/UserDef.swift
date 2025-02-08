//
//  UserDef.swift
//  ICounted
//
//  Created by Nebo on 06.02.2025.
//

import Foundation

enum UserDefKeys: String {
    case isUserSawTooltipLongpressInCounterListScreen = "isUserSawTooltipLongpressInCounterListScreen"
    case isUserSawTooltipLongpressInCounterScreen = "isUserSawTooltipLongpressInCounterScreen"
    case userLacalize = "userLacalize"
    case isDarkModeEnabled = "isDarkModeEnabled"
}

extension UserDefaults {
    func get(case key: UserDefKeys) -> Any? {
        UserDefaults.standard.object(forKey: key.rawValue)
    }
    
    func set(_ value: Any?, case key: UserDefKeys) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
}
