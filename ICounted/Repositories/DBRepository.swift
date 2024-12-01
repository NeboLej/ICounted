//
//  DBRepository.swift
//  ICounted
//
//  Created by Nebo on 01.12.2024.
//

import Foundation
import SwiftData

protocol DBRepositoryProtocol {
    func getAllCounters() -> [Counter]
    func saveCounter(newCounter: Counter)
}

class DBRepository: DBRepositoryProtocol {

    let context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }
    
    func getAllCounters() -> [Counter] {
        loadCountersFromDB()
    }
    
    func saveCounter(newCounter: Counter) {
        context.insert(newCounter)
        do {
            try context.save()
        } catch {
            print("Ошибка загрузки задач: \(error)")
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


class DBRepositoryMock: DBRepositoryProtocol {
    
    func getAllCounters() -> [Counter] {
        []
    }
    
    func saveCounter(newCounter: Counter) {
        
    }
    
}
