//
//  ICountedApp.swift
//  ICounted
//
//  Created by Nebo on 07.07.2024.
//

import SwiftUI
import WidgetKit

@main
struct ICountedApp: App {
    
    private let container = sharedModelContainer
    private let countersStore: CountersStore
    private let screenBuilder: ScreenBuilder
    
    @Environment(\.scenePhase) private var scenePhase
    
    
    init() {
        
//        let schema = Schema([Counter.self, CounterRecord.self])
//        let config = ModelConfiguration(schema: schema, cloudKitDatabase: .automatic)
//        container = try! ModelContainer(for: schema, configurations: config)
        
        let dataBase: DBRepository = DBRepository(context: container.mainContext)
        let localRepository: DBRepositoryProtocol = DBCounterRepository(swiftDataDB: dataBase)
        
        countersStore = CountersStore(localRepository: localRepository)
        screenBuilder = ScreenBuilder(countersStore: countersStore)
    }
    
    
    var body: some Scene {
        WindowGroup {
            screenBuilder.getScreen(screenType: .counterList)
//                .overlay {
//                    if store.state.alert != nil {
//                        AlertView(model: store.state.alert!, store: store)
//                    }
//                }
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
