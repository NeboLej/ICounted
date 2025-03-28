//
//  Counter.swift
//  ICounted
//
//  Created by Nebo on 28.09.2024.
//

import Foundation
import SwiftData

@Model
class Counter: Identifiable, Equatable, HasUUID, ObservableObject {
    var id: UUID = UUID.init()
    var name: String = "def"
    var desc: String = "def"
    var count: Int = 0
    var lastRecord: Date?
    var colorHex: String = "def"
    var isFavorite: Bool = false
    var targetCount: Int?
    var dateCreate: Date = Date()
    
    @Relationship(deleteRule: .cascade, inverse: \CounterRecord.counter) var records: [CounterRecord]?
    
    init(id: UUID = .init(), name: String = "def", desc: String = "def", count: Int = 0, lastRecord: Date? = nil, colorHex: String = "FFFFFF", isFavorite: Bool = true, targetCount: Int? = nil, dateCreate: Date = Date()) {
        self.id = id
        self.name = name
        self.desc = desc
        self.count = count
        self.lastRecord = lastRecord
        self.colorHex = colorHex
        self.isFavorite = isFavorite
        self.targetCount = targetCount
        self.dateCreate = dateCreate
        self.records = []
    }
    
    func copy(name: String? =  nil, desc: String? = nil, count: Int? = nil, colorHex: String? = nil, isFavorite: Bool? = nil, targetCount: Int? = nil, dateCreate: Date? = nil) -> Counter {
        self.name = name ?? self.name
        self.desc = desc ?? self.desc
        self.count = count ?? self.count
        self.colorHex = colorHex ?? self.colorHex
        self.isFavorite = isFavorite ?? self.isFavorite
        self.targetCount = targetCount ?? self.targetCount
        self.dateCreate = dateCreate ?? self.dateCreate
        return self
    }
    
    func modify(count: Int? = nil, isFavorite: Bool? = nil) {
        self.count = count ?? self.count
        self.isFavorite = isFavorite ?? self.isFavorite
    }
    
    func addRecord(record: CounterRecord) {
        records?.append(record)
    }
}

extension Counter {
    var progress: Double? {
        guard let targetCount, targetCount > 0 else { return nil }
        return (100 / Double(targetCount)) * Double(count)
    }
}
