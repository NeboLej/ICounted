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
    
    func perform() async throws -> some IntentResult {
        guard let uuid = UUID(uuidString: counterId) else { return .result() }
        let counterWidgetManager = await CounterWidgetManager()
        await counterWidgetManager.countPlus(counterID: uuid)
        return .result()
    }
}

@MainActor
struct CounterWidgetManager {
    private let modelContainer = sharedModelContainer
    private let localRepository: DBCounterRepository
    
    init() {
        let dataBase: DBRepository = DBRepository(context: modelContainer.mainContext)
        localRepository = DBCounterRepository(swiftDataDB: dataBase)
    }
    
    func countPlus(counterID: UUID, message: String? = nil) {
        Vibration.light.vibrate()
        guard let counter = localRepository.getCounter(id: counterID) else { return }
        localRepository.plusCount(counter: counter, message: message)
        try? modelContainer.mainContext.save()
    }
}
