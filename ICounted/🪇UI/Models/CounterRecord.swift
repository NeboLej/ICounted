//
//  CounterRecord.swift
//  ICounted
//
//  Created by Nebo on 30.10.2024.
//

import Foundation
import SwiftData

@Model
class CounterRecord: Identifiable, Equatable {
    let id: UUID = UUID.init()
    let date: Date = Date()
    let message: String = "def"
    let counter: Counter? = nil
    
    init(id: UUID = .init(), date: Date = Date(), message: String = "", counter: Counter? = nil) {
        self.id = id
        self.date = date
        self.message = message
        self.counter = counter
    }
}
