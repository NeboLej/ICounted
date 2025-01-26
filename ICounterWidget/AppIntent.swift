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
    
    static var title: LocalizedStringResource = "Do nothing"
    @Parameter(title: "counterId") var counterId: String
    
    init(counterId: String) {
        self.counterId = counterId
    }
    init() { } //req
    
    func perform() async throws -> some IntentResult {
        guard let uuid = UUID(uuidString: counterId) else { return .result() }
        let counterWidgetManager = await CounterWidgetManager(modelContainer: sharedModelContainer)
        await counterWidgetManager.countPlus(counterID: uuid)
        return .result()
    }
}

@MainActor
struct CounterWidgetManager {
    private let modelContainer: ModelContainer
    private let localRepository: DBCounterRepository
    
    init(modelContainer: ModelContainer) {
        self.modelContainer = modelContainer
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
