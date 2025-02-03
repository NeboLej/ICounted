//
//  EditCounterStore.swift
//  ICounted
//
//  Created by Nebo on 03.02.2025.
//

import SwiftUI

@Observable
class EditCounterStore {
    
    var id: UUID?
    var name: String = ""
    var description: String = ""
    var color: Color = .blue
    var count: Int = 0
    var isUseTargetValue = false
    var targetCount: Int = 0
    var isAddToWidget = false
    var records: [CounterRecord] = []
    
    var selectedDate: Date?
    var recordsDate: [Date] = []
    var counter: Counter!
    
    func bindCounter(counter: Counter) {
        self.counter = counter
        id = counter.id
        name = counter.name
        description = counter.desc
        color = Color(hex: counter.colorHex)
        count = counter.count
        isUseTargetValue = counter.targetCount != nil
        targetCount =  counter.targetCount != nil ?  counter.targetCount! : 0
        isAddToWidget = counter.isFavorite
        recordsDate = counter.records?.map { $0.date } ?? []
        records = counter.records ?? []
    }
    
    func saveCounter() -> Counter {
        counter.copy(name: name, desc: description, colorHex: color.toHex(), isFavorite: isAddToWidget, targetCount: isUseTargetValue ? targetCount : nil)
    }
    
}
