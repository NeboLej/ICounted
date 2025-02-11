//
//  ICountedApp.swift
//  ICounted
//
//  Created by Nebo on 07.07.2024.
//

import SwiftUI
import WidgetKit
import Combine
import SwiftData

@main
struct ICountedApp: App {
    
    @Query(sort: \Counter.name, order: .forward) private var counters: [Counter]
    @Environment(\.colorScheme) var colorScheme
    
    private let container = sharedModelContainer
    private let countersStore: CountersStore
    private var screenBuilder: ScreenBuilder
    private let settingsStore: SettingStore
    
    @Environment(\.scenePhase) private var scenePhase
    
    init() {
        
        let dataBase: DBRepository = DBRepository(context: container.mainContext)
        let localRepository: DBRepositoryProtocol = DBCounterRepository(swiftDataDB: dataBase)
        
        settingsStore = SettingStore()
        countersStore = CountersStore(localRepository: localRepository)
        screenBuilder = ScreenBuilder(countersStore: countersStore, settingsStore: settingsStore)
    }
    

    
    var body: some Scene {
        WindowGroup {
            screenBuilder.getScreen(screenType: .counterList)
                .id(settingsStore.refreshID)
                .preferredColorScheme(settingsStore.isDarkMode == nil ? settingsStore.getSystemTheme() : settingsStore.isDarkMode == true ? .dark : .light)
                .onAppear {
                    NotificationCenter.default.addObserver(forName: .NSPersistentStoreRemoteChange, object: nil, queue: .main) { _ in
                        countersStore.updateAllCounters()
                    }
                }

//                .overlay {
//                    if store.state.alert != nil {
//                        AlertView(model: store.state.alert!, store: store)
//                    }
//                }
        }
        .onChange(of: counters) { oldValue, newValue in
            countersStore.updateAllCounters()
        }
        .onChange(of: scenePhase) {
            switch scenePhase {
            case .active:
                countersStore.updateAllCounters()
            case .inactive:
                break
            case .background:
                WidgetCenter.shared.reloadAllTimelines()
            @unknown default:
                break
            }
        }
        
    }
}

@Observable
class AppState  {
    var shouldRestart: Bool = false

    func restart() {
        shouldRestart = true
    }
}
