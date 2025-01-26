//
//  ICountedApp.swift
//  ICounted
//
//  Created by Nebo on 07.07.2024.
//

import SwiftUI
//import SwiftData

@main
struct ICountedApp: App {
    
    let container = sharedModelContainer
    let countersStore: CountersStore
    let screenBuilder: ScreenBuilder
    
    
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
    }
}
