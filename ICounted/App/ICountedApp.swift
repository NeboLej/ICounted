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
        self.container = try! ModelContainer(for: Counter.self)
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
