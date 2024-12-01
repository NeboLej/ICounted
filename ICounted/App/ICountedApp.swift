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
    let countersStore: CountersStore
    let screenBuilder: ScreenBuilder
    
    
    init() {
        
        let schema = Schema([Counter.self, CounterRecord.self])
        let config = ModelConfiguration(schema: schema, cloudKitDatabase: .automatic)
        container = try! ModelContainer(for: schema, configurations: config)
        
        let dataBase: DBRepository = DBRepository(context: container.mainContext)
        let localRepository: DBRepositoryProtocol = DBCounterRepository(swiftDataDB: dataBase)
        
        countersStore = CountersStore(localRepository: localRepository)
        screenBuilder = ScreenBuilder(countersStore: countersStore)
        
        
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
            screenBuilder.getScreen(screenType: .counterList)
//            CountersListScreen()
//                .environment(\.countersStore, countersStore)
//                .overlay {
//                    if store.state.alert != nil {
//                        AlertView(model: store.state.alert!, store: store)
//                    }
//                }
        }
    }
}
