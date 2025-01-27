//
//  CounterScreenStore.swift
//  ICounted
//
//  Created by Nebo on 06.10.2024.
//

import SwiftUI

@Observable
class CounterScreenStore {
    
    var name: String = ""
    var description: String = ""
    var color: Color = .blue
    var count: Int = 0
    var isUseTargetValue = false
    var targetCount: Int = 0
    var isAddToWidget = false
    var progress: Double = 0
    var records: [CounterRecord] = []
    var id: UUID?
    var selectedDate: Date?
    var recordsDate: [Date] = []
    
    var selectedRecords: [CounterRecord] {
        if selectedDate == nil { return [] }
        return records.filter({ $0.date.isSameDay(date: selectedDate!) }).reversed()
    }
    
    var alert: AlertModel?
    
    func bindCounter(counter: Counter) {
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
        
        progress = getProgress()
    }
    
    private func getProgress() -> Double {
        if targetCount == 0 { return 1 }
        return (100 / Double(targetCount)) * Double(count)
    }
    
    func showAlert(positiveAction: @escaping ()->(), negativeAction: @escaping ()->()) {
        alert = AlertModel(type: .warning, title: "", message: Localized.Counter.alertDeleteMessage(name), actions: [.init(name: Localized.Counter.alertDeleteYesButton, completion: positiveAction), .init(name: Localized.Counter.alertDeleteNoButton, completion: negativeAction)])
    }
}
