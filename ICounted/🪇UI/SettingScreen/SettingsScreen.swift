//
//  SettingsScreen.swift
//  ICounted
//
//  Created by Nebo on 06.02.2025.
//

import SwiftUI

struct SettingsScreen: View {
    
    @Environment(\.settingsStore) var settingsStore: SettingStore
    
    var body: some View {
        @Bindable var store = settingsStore
        VStack(spacing: 0) {
            ICHeaderView(name: Localized.shared.settings.title, color: .background3)
            
            List {
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
                
                HStack {
                    Text(Localized.shared.settings.darkMode)
                    Spacer()
                    ICToggleControlView(isOn: $store.isDarkTheme, color: .background3)
                }.padding(.vertical, 4)
                
                Picker("Сортировка счетчиков", selection: $store.sortType) {
                    ForEach(Settings.SortType.allCases, id: \.self) {
                        Text($0.getSortType()).tag($0)
                    }
                }.padding(.vertical, 2)
                
                HStack {
                    Text("О приложении")
                    Spacer()
                    Image(systemName: "chevron.right")
                }.padding(.vertical, 4)
                
                HStack {
                    Text("Поддержать разработчика")
                    Spacer()
                    Image(systemName: "star.fill")
                        .foregroundStyle(.red)
                }.padding(.vertical, 6)
                
                HStack {
                    Text(Localized.shared.settings.version)
                    Spacer()
                    Text(store.appVersion ?? "-")
                }.padding(.vertical, 4)
            }
        }
    }
}

#Preview {
    ScreenBuilder.shared.getScreen(screenType: .settings)
}

@Observable
class SettingStore: BaseStore {
    var isReturnToSettings: Bool = false
    var local: LocalizationType = LocalizationManager.shared.getCurrentLocalization()
    var sortType: Settings.SortType = .name
    var isDarkTheme: Bool = false
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    
    var refreshID = UUID()

    func restart() {
        isReturnToSettings = true
        refreshID = UUID()
    }
}

struct Settings {
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
