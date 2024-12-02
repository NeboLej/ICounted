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
    var id: UUID = UUID.init()
    var date: Date = Date()
    var message: String = "def"
    var counter: Counter? = nil
    
    init(id: UUID = .init(), date: Date = Date(), message: String = "", counter: Counter? = nil) {
        self.id = id
        self.date = date
        self.message = message
        self.counter = counter
    }
}
