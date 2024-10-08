//
//  Counter.swift
//  ICounted
//
//  Created by Nebo on 28.09.2024.
//

import Foundation

struct Counter: Identifiable, Equatable {
    let id: UUID
    let name: String
    let description: String
    let count: Int
    let lastRecord: Date
    let colorHex: String
    let isFavorite: Bool
    let taggetCount: Int?
    
    init(id: UUID = .init(), name: String, description: String, count: Int, lastRecord: Date, colorHex: String, isFavorite: Bool, taggetCount: Int?) {
        self.id = id
        self.name = name
        self.description = description
        self.count = count
        self.lastRecord = lastRecord
        self.colorHex = colorHex
        self.isFavorite = isFavorite
        self.taggetCount = taggetCount
    }
    
    func copy(count: Int? = nil, isFavorite: Bool? = nil) -> Counter {
        Counter(id: id, name: name, description: description, count: count ?? self.count, lastRecord: lastRecord, colorHex: colorHex, isFavorite: isFavorite ?? self.isFavorite, taggetCount: taggetCount)
    }
}
