//
//  SettingStore.swift
//  ICounted
//
//  Created by Nebo on 08.02.2025.
//

import UIKit
import SwiftUI

@Observable
class SettingStore: BaseStore {
    var isReturnToSettings: Bool = false
    var local: LocalizationType = LocalizationManager.shared.getCurrentLocalization()
    var sortType: Settings.SortType = Settings.SortType(rawValue: UserDefaults.standard.get(case: .sortType) as? String ?? "") ?? .dateCreate
    var isDarkMode: Bool? = UserDefaults.standard.get(case: .isDarkModeEnabled) as? Bool
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    
    var themeType: Settings.ThemeType
    
    var refreshID = UUID()
    
    override init() {
        let isUseDarkMode = UserDefaults.standard.get(case: .isDarkModeEnabled) as? Bool
        
        themeType = if isUseDarkMode == nil {
            .system
        } else if isUseDarkMode == true {
            .dark
        } else {
            .light
        }
        
        super.init()
    }
    

    func getSystemTheme() -> ColorScheme {
        let systemColorScheme = UIScreen.main.traitCollection.userInterfaceStyle
        return switch systemColorScheme {
        case .dark: .dark
        case .light: .light
        default: .light
        }
    }
    
    func changeTheme(_ theme: Settings.ThemeType) {
        let value: Bool? = switch theme {
        case .dark: true
        case .light: false
        case .system: nil
        }
        UserDefaults.standard.set(value, case: .isDarkModeEnabled)
        isDarkMode = value
    }
    
    func changeSortType(_ sortType: Settings.SortType) {
        UserDefaults.standard.set(sortType.rawValue, case: .sortType)
    }
    
    func restart() {
        isReturnToSettings = true
        refreshID = UUID()
    }
}

struct Settings {
    
    enum ThemeType: CaseIterable, Hashable {
        case light
        case dark
        case system
        
        func getThemeName() -> String {
            switch self {
            case .light: Localized.shared.settings.lightMode
            case .dark: Localized.shared.settings.darkMode
            case .system: Localized.shared.settings.systemMode
            }
        }
    }
    
    enum SortType: String, CaseIterable, Hashable {
        case dateCreate = "dateCreate"
        case name = "name"
        case dateRecord = "dateRecord"
        case recordCount = "countRecord"
        
        func getSortType() -> String {
            switch self {
            case .dateCreate: Localized.shared.settings.dateCreateSorting
            case .name: Localized.shared.settings.nameSorting
            case .dateRecord: Localized.shared.settings.dateRecordSorting
            case .recordCount: Localized.shared.settings.countRecordsSorting
            }
        }
    }
}
