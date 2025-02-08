//
//  SettingsScreen.swift
//  ICounted
//
//  Created by Nebo on 06.02.2025.
//

import SwiftUI

struct SettingsScreen: View {
    
    @Environment(\.settingsStore) var settingsStore: SettingStore
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        @Bindable var store = settingsStore
        VStack(spacing: 0) {
            ICHeaderView(name: Localized.shared.settings.title, color: .background2)
            
            List {
                Section {
                    Picker(Localized.shared.settings.language, selection: $store.local) {
                        ForEach(LocalizationType.allCases, id: \.self) {
                            Text($0.getLanguage()).tag($0)
                        }
                    }
                    .padding(.vertical, 2)
                    .onChange(of: store.local) { oldValue, newValue in
                        LocalizationManager.shared.setLocalization(newValue)
                        settingsStore.restart()
                    }
                    
                    
                    Picker(Localized.shared.settings.darkMode, selection: $store.themeType) {
                        ForEach(Settings.ThemeType.allCases, id: \.self) {
                            Text($0.getThemeName()).tag($0)
                        }
                    }
                    .padding(.vertical, 2)
                    .onChange(of: store.themeType) { oldValue, newValue in
                        settingsStore.changeTheme(newValue)
                    }
                    
                    Picker("Сортировка счетчиков", selection: $store.sortType) {
                        ForEach(Settings.SortType.allCases, id: \.self) {
                            Text($0.getSortType()).tag($0)
                        }
                    }.padding(.vertical, 2)
                }
                
                Section {
                    
                    
                    HStack {
                        Text("Поддержать разработчика")
                        Spacer()
                        Image(systemName: "star.fill")
                            .foregroundStyle(.red)
                    }.padding(.vertical, 6)
                    
                }.listRowBackground(Color.indigo)
                
                Section {
                    
                    HStack {
                        Text("О приложении")
                        Spacer()
                        Image(systemName: "chevron.right")
                    }.padding(.vertical, 4)
                    HStack {
                        Text(Localized.shared.settings.version)
                        Spacer()
                        Text(store.appVersion ?? "-")
                    }.padding(.vertical, 4)
                }//.listRowBackground(Color.background1)
            }
        }
        //.scrollContentBackground(.hidden)
        //.background(.background2)
        .preferredColorScheme(settingsStore.isDarkMode == nil ? settingsStore.getSystemTheme() : settingsStore.isDarkMode == true ? .dark : .light)
    }
}

#Preview {
    ScreenBuilder.shared.getScreen(screenType: .settings)
}


import UIKit

@Observable
class SettingStore: BaseStore {
    var isReturnToSettings: Bool = false
    var local: LocalizationType = LocalizationManager.shared.getCurrentLocalization()
    var sortType: Settings.SortType = .name
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
            case .light: "Светлая"
            case .dark: "Темная"
            case .system: "Как в системе"
            }
        }
    }
    
    enum SortType: CaseIterable, Hashable {
        case dateCreate
        case name
        case dateRecord
        
        func getSortType() -> String {
            switch self {
            case .dateCreate: "Дата создания"
            case .name: "Название"
            case .dateRecord: "Дата записи"
            }
        }
    }
}
