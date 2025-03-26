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
    func plusCount(counter: Counter, message: String?, date: Date?)
    func favoriteToggle(counter: Counter)
    func deleteCounter(counter: Counter)
    func deleteRecord(record: CounterRecord, counter: Counter)
}

class DBCounterRepository: DBRepositoryProtocol {
    
    private let swiftDataDB: DBRepository
    
    init(swiftDataDB: DBRepository) {
        self.swiftDataDB = swiftDataDB
    }
    
    func getCounter(id: UUID) -> Counter? {
        do {
            return try swiftDataDB.getByID(id: id)
        } catch {
            print("Ошибка получения счетчика: \(id.uuidString)")
            return nil
        }
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
    
    func plusCount(counter: Counter, message: String? = nil, date: Date? = nil) {
        counter.modify(count: counter.count + 1)
        counter.addRecord(record: CounterRecord(date: date == nil ? Date() : date!, message: message ?? "", counter: counter))
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
    
    func deleteRecord(record: CounterRecord, counter: Counter) {
        do {
            try swiftDataDB.delete(model: record)
            counter.modify(count: counter.count - 1)
        } catch {
            print("Ошибка удаления записи: \(error)")
        }
    }
}


class DBRepositoryMock: DBRepositoryProtocol {
    
    var counters: [Counter] = [.init(name: "asdsd", desc: "asdasdsd", count: 123, lastRecord: nil, colorHex: "95D385", isFavorite: true, targetCount: nil, dateCreate: Date()),
                               .init(name: "assssssOO", desc: "sdasdsddsdsdsd sdasd ", count: 10, lastRecord: Date(), colorHex: "F58F8F", isFavorite: false, targetCount: 100, dateCreate: Date())]
    
    
    func getAllCounters() -> [Counter] {
        counters
    }
    
    func saveCounter(newCounter: Counter) {
        counters.append(newCounter)
    }
    
    func plusCount(counter: Counter, message: String?, date: Date?) {
        counter.modify(count: counter.count + 1)
    }
    
    func favoriteToggle(counter: Counter) {
        counter.modify(isFavorite: !counter.isFavorite)
    }
    
    func deleteCounter(counter: Counter) {
        counters.removeAll(where: { $0.id == counter.id })
    }
    
    func deleteRecord(record: CounterRecord, counter: Counter) {
        counters.forEach { counter in
            counter.records?.removeAll(where: { $0.id == record.id })
        }
    }
}
