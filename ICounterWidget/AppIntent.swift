//
//  AppIntent.swift
//  ICounterWidget
//
//  Created by Nebo on 25.01.2025.
//

import WidgetKit
import AppIntents
import SwiftData

struct PlusCountIntent: AppIntent {
    
    static var title: LocalizedStringResource = LocalizedStringResource("widget_add_count_intent_name")
    @Parameter(title: "counterId") var counterId: String
    
    init(counterId: String) {
        self.counterId = counterId
    }
    init() { } //req
    
    @MainActor
    func perform() async throws -> some IntentResult {
        guard let uuid = UUID(uuidString: counterId) else { return .result() }
        let counterWidgetManager = CounterWidgetManager()
        counterWidgetManager.countPlus(counterID: uuid)
        return .result()
    }
}

@MainActor
struct CounterWidgetManager {
    private let modelContainer = sharedModelContainer
    private let localRepository: DBCounterRepository
    let context = sharedModelContainer.mainContext
    
    init() {
        let dataBase: DBRepository = DBRepository(context: modelContainer.mainContext)
        localRepository = DBCounterRepository(swiftDataDB: dataBase)
    }
    
    func countPlus(counterID: UUID, message: String? = nil) {
        Vibration.light.vibrate()
        
        let counters = (try? context.fetch(FetchDescriptor<Counter>())) ?? []
        guard let counter = counters.first(where: { $0.id == counterID }) else { return }
        
//        guard let counter = localRepository.getCounter(id: counterID) else { return }
        localRepository.plusCount(counter: counter, message: message)
        try? modelContainer.mainContext.save()
    }
}
