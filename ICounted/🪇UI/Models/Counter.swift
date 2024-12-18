//
//  Counter.swift
//  ICounted
//
//  Created by Nebo on 28.09.2024.
//

import Foundation
import SwiftData

@Model
class Counter: Identifiable, Equatable {
    var id: UUID = UUID.init()
    var name: String = "def"
    var desc: String = "def"
    var count: Int = 0
    var lastRecord: Date?
    var colorHex: String = "def"
    var isFavorite: Bool = false
    var targetCount: Int?
    
    @Relationship(deleteRule: .cascade, inverse: \CounterRecord.counter) var records: [CounterRecord]? = []
    
    init(id: UUID = .init(), name: String, desc: String, count: Int, lastRecord: Date?, colorHex: String, isFavorite: Bool, targetCount: Int?) {
        self.id = id
        self.name = name
        self.desc = desc
        self.count = count
        self.lastRecord = lastRecord
        self.colorHex = colorHex
        self.isFavorite = isFavorite
        self.targetCount = targetCount
    }
    
    func copy(count: Int? = nil, isFavorite: Bool? = nil) -> Counter {
        self.count = count ?? self.count
        self.isFavorite = isFavorite ?? self.isFavorite
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
