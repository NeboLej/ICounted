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
//    let store: Store<CounterListState, CounterListAction>
    @State var countersStore: CountersStore
    
    
    
    init() {
        
        let schema = Schema([Counter.self, CounterRecord.self])
        let config = ModelConfiguration(schema: schema, cloudKitDatabase: .automatic)
        container = try! ModelContainer(for: schema, configurations: config)
        
        let localRepository: DBRepositoryProtocol = DBRepository(context: container.mainContext)
        
        countersStore = CountersStore(localRepository: localRepository)
        
//        self.store = Store(
//            initial: CounterListState(),
//            reducer: counterListReducer,
//            middleware: [
//                AnyMiddleware(NewCounterValidationMiddleware()),
//                AnyMiddleware(DBMiddleware(context: container.mainContext))
//            ]
//        )
//        self.store.dispatch(.loadCounters)
    }
    
    
    var body: some Scene {
        WindowGroup {
            CountersListScreen()
                .environment(countersStore)
//                .overlay {
//                    if store.state.alert != nil {
//                        AlertView(model: store.state.alert!, store: store)
//                    }
//                }
        }
    }
}
