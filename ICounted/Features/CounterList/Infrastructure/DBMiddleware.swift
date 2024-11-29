//
//  DBMiddleware.swift
//  ICounted
//
//  Created by Nebo on 29.10.2024.
//

import Foundation
import SwiftData

struct DBMiddleware: Middleware {
    
    private var context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }
    
    func process(action: CounterListAction, state: CounterListState, next: @escaping (CounterListAction) -> Void) {
        switch action {
        case .countPlus(let counterId):
            if let counterIndex = state.counters.firstIndex(where: { $0.id == counterId }) {
                let counter = state.counters[counterIndex]
                let newRecord = CounterRecord(counter: counter)
                counter.modify(count: counter.count + 1)
//                context.insert(counter)
//                context.insert(newRecord)
//                
//                try? context.save()
//                next(.countersLoaded(loadCountersFromDB()))
            }
        case .countMinus(let counterId):
            if let counterIndex = state.counters.firstIndex(where: { $0.id == counterId }) {
                let counter = state.counters[counterIndex]
                let newCount = counter.count - 1
                context.insert(counter.copy(count: newCount >= 0 ? newCount :  counter.count))
                try? context.save()
                next(.countersLoaded(loadCountersFromDB()))
            }
        case .toggleIsFavorite(let counterId):
            if let counterIndex = state.counters.firstIndex(where: { $0.id == counterId }) {
                let counter = state.counters[counterIndex]
                context.insert(counter.copy(isFavorite: !counter.isFavorite))
                try? context.save()
                next(.countersLoaded(loadCountersFromDB()))
            }
        case .addCounter(let counter):
            context.insert(counter)
            try? context.save()
            next(.countersLoaded(loadCountersFromDB()))
            next(.moveToScreen(screen: .counterList))
        case .deleteCounter(let counterId):
            if let counterToRemove = state.counters.first(where: { $0.id == counterId }) {
                context.delete(counterToRemove)
                try? context.save()
                next(.countersLoaded(loadCountersFromDB()))
            }
        case .loadCounters:
            let counters = loadCountersFromDB()
            next(.countersLoaded(counters))
        default: next(action)
        }
    }
    
    private func loadCountersFromDB() -> [Counter] {
        do {
            let fetchDescriptor = FetchDescriptor<Counter>()
            return try context.fetch(fetchDescriptor)
        } catch {
            print("Ошибка загрузки задач: \(error)")
            return []
        }
    }
}
