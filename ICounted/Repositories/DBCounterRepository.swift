//
//  DBRepository.swift
//  ICounted
//
//  Created by Nebo on 01.12.2024.
//

import Foundation

protocol DBRepositoryProtocol {
    func getAllCounters() -> [Counter]
    func saveCounter(newCounter: Counter)
    func plusCount(counter: Counter)
    func favoriteToggle(counter: Counter)
    func deleteCounter(counter: Counter)
}

class DBCounterRepository: DBRepositoryProtocol {

    private let swiftDataDB: DBRepository

    init(swiftDataDB: DBRepository) {
        self.swiftDataDB = swiftDataDB
    }
    
    func getAllCounters() -> [Counter] {
        do {
            return try swiftDataDB.getAll()
        } catch {
            print("Ошибка получения счетчиков: \(error)")
            return []
        }
    }
    
    func saveCounter(newCounter: Counter) {
        do {
            try swiftDataDB.save(model: newCounter)
        } catch {
            print("Ошибка сохранения счетчика: \(error)")
        }
    }
    
    func plusCount(counter: Counter) {
        counter.modify(count: counter.count + 1)
    }
    
    func favoriteToggle(counter: Counter) {
        counter.modify(isFavorite: !counter.isFavorite)
    }
    
    func deleteCounter(counter: Counter) {
        do {
            try swiftDataDB.delete(model: counter)
        } catch {
            print("Ошибка удаления счетчика: \(error)")
        }
    }
}


class DBRepositoryMock: DBRepositoryProtocol {

    var counters: [Counter] = [.init(name: "asdsd", desc: "asdasdsd", count: 123, lastRecord: nil, colorHex: "95D385", isFavorite: true, targetCount: nil),
                              .init(name: "assssssOO", desc: "sdasdsddsdsdsd sdasd ", count: 10, lastRecord: Date(), colorHex: "95D385", isFavorite: false, targetCount: 100)]
    
    
    func getAllCounters() -> [Counter] {
        counters
    }
    
    func saveCounter(newCounter: Counter) {
        counters.append(newCounter)
    }
    
    func plusCount(counter: Counter) {
        counter.modify(count: counter.count + 1)
    }
    
    func favoriteToggle(counter: Counter) {
        counter.modify(isFavorite: !counter.isFavorite)
    }
    
    func deleteCounter(counter: Counter) {
        counters.removeAll(where: { $0.id == counter.id })
    }
}