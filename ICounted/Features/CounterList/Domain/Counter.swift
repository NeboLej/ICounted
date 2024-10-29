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
    @Attribute(.unique) var id: UUID
    let name: String
    let desc: String
    let count: Int
    let lastRecord: Date?
    let colorHex: String
    let isFavorite: Bool
    let targetCount: Int?
    
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
        Counter(id: id, name: name, desc: desc, count: count ?? self.count, lastRecord: lastRecord, colorHex: colorHex, isFavorite: isFavorite ?? self.isFavorite, targetCount: targetCount)
    }
}

extension Counter {
    
    var progress: Double? {
        guard let targetCount, targetCount > 0 else { return nil }
        return (100 / Double(targetCount)) * Double(count)
    }
    
}
