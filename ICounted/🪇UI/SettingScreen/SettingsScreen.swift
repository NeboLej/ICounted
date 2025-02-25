//
//  SettingsScreen.swift
//  ICounted
//
//  Created by Nebo on 06.02.2025.
//

import SwiftUI
import StoreKit

struct SettingsScreen: View {
    
    @Environment(\.settingsStore) var settingsStore: SettingStore
    @Environment(\.colorScheme) var colorScheme
    
    @State private var localStore = SettingsScreenStore()
    
    var body: some View {
        @Bindable var store = settingsStore
        NavigationStack {
            
        
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
                    
                    Picker(Localized.shared.settings.themeInterface, selection: $store.themeType) {
                        ForEach(Settings.ThemeType.allCases, id: \.self) {
                            Text($0.getThemeName()).tag($0)
                        }
                    }
                    .padding(.vertical, 2)
                    .onChange(of: store.themeType) { oldValue, newValue in
                        settingsStore.changeTheme(newValue)
                    }
                    
                    Picker(Localized.shared.settings.sortingCounters, selection: $store.sortType) {
                        ForEach(Settings.SortType.allCases, id: \.self) {
                            Text($0.getSortType()).tag($0)
                        }
                    }.padding(.vertical, 2)
                        .onChange(of: store.sortType) { oldValue, newValue in
                            settingsStore.changeSortType(newValue)
                        }
                    
                }
                
//                
//                Section {
//                    NavigationLink(destination: SubscriptionStoreView(groupID: "21637447", visibleRelationships: .all)) {
//                        HStack {
//                            Text(Localized.shared.settings.supportTheDeveloper)
//                            Spacer()
//                            Image(systemName: "star.fill")
//                                .foregroundStyle(.red)
//                        }
//                        .padding(.vertical, 8)
//                    }
//                }
//                .listRowBackground(Color.indigo)
//                
                
                Section {
                    HStack {
                        Text(Localized.shared.settings.sendFeedback)
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    .padding(.vertical, 6)
                    .onTapGesture {
                        localStore.openSendProblemScreen()
                    }
                    
                    HStack {
                        Text(Localized.shared.settings.version)
                        Spacer()
                        Text(store.appVersion ?? "-")
                    }.padding(.vertical, 4)
                }
                
                Section {
                    HStack {
                        Text(Localized.shared.settings.rateApp)
                        Spacer()
                        Image(systemName: "star.fill")
                            .foregroundStyle(.yellow)
                    }
                    .padding(.vertical, 8)
                }
                .listRowBackground(Color.red)
                .onTapGesture {
                    localStore.openAppStore()
                }
            }
            }
        }
        //.scrollContentBackground(.hidden)
        //.background(.background2)
        .preferredColorScheme(settingsStore.isDarkMode == nil ? settingsStore.getSystemTheme() : settingsStore.isDarkMode == true ? .dark : .light)
        .modifier(AlertModifier(alert: localStore.alert))
        .task {
            do {
                try await localStore.loadProducts()
            } catch {
                print(error)
            }
        }
    }
}

#Preview {
    ScreenBuilder.shared.getScreen(screenType: .settings)
}
