//
//  ICountedApp.swift
//  ICounted
//
//  Created by Nebo on 07.07.2024.
//

import SwiftUI
import SwiftData

@main
struct ICountedApp: App {
    
    let container: ModelContainer
    let store: Store<CounterListState, CounterListAction>
    
    init() {
//        let storeURL = URL.documentsDirectory.appending(path: "database.sqlite")
        let schema = Schema([Counter.self, CounterRecord.self])
        let config = ModelConfiguration(schema: schema, cloudKitDatabase: .automatic)
        container = try! ModelContainer(for: schema, configurations: config)
        
        
//        let container: ModelContainer = {
//            // Don't force unwrap for real 👀
//            try! ModelContainer(
//                for: [Brew.self],
//                .init(cloudKitContainerIdentifier: "icloud.uk.co.alexanderlogan.samples.Brew-Book") // we'll come back to this one
//            )
//        }()
//        
        
//        self.container = try! ModelContainer(for: [Counter.self, CounterRecord.self])
        self.store = Store(
            initial: CounterListState(),
            reducer: counterListReducer,
            middleware: [
                AnyMiddleware(NewCounterValidationMiddleware()),
                AnyMiddleware(DBMiddleware(context: container.mainContext))
            ]
        )
        self.store.dispatch(.loadCounters)
    }
    
    
    var body: some Scene {
        WindowGroup {
            CountersListScreen(store: store)
                .overlay {
                    if store.state.alert != nil {
                        AlertView(model: store.state.alert!, store: store)
                    }
                }
        }
    }
}
