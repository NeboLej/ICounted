//
//  Counter.swift
//  ICounted
//
//  Created by Nebo on 28.09.2024.
//

import Foundation

struct Counter: Identifiable {
    let id: UUID = .init()
    let name: String
    let description: String
    let count: Int
    let lastRecord: Date
    let colorHex: String
    let isFavorite: Bool
    let taggetCount: Int?
    
    
    func copy(count: Int? = nil, isFavorite: Bool? = nil) -> Counter {
        Counter(name: name, description: description, count: count ?? self.count, lastRecord: lastRecord, colorHex: colorHex, isFavorite: isFavorite ?? self.isFavorite, taggetCount: taggetCount)
    }
}
