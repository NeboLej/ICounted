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
    var selectedDate: Date? = Date()
    var recordsDate: [Date] = []
    
    var isShowTooltip: Bool = !(UserDefaults.standard.get(case: .isUserSawTooltipLongpressInCounterScreen) as? Bool ?? false)
    
    
    var selectedRecords: [CounterRecord] {
        if selectedDate == nil { return [] }
        return records.filter({ $0.date.isSameDay(date: selectedDate!) }).sorted(by: { $0.date > $1.date })
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
    
    func showAlertDeleteCounter(positiveAction: @escaping ()->(), negativeAction: @escaping ()->()) {
        alert = AlertModel(type: .warning, title: "", message: Localized.shared.counter.alertDeleteMessage(name), actions: [.init(name: Localized.shared.counter.alertDeleteYesButton, completion: positiveAction), .init(name: Localized.shared.counter.alertDeleteNoButton, completion: negativeAction)])
    }
    
    func showAlertDeleteRecord(positiveAction: @escaping ()->(), negativeAction: @escaping ()->()) {
        alert = AlertModel(type: .warning, title: "", message: Localized.shared.counter.alertDeleteRecordMessage, actions: [.init(name: Localized.shared.counter.alertDeleteYesButton, completion: positiveAction), .init(name: Localized.shared.counter.alertDeleteNoButton, completion: negativeAction)])
    }
    
    func didUserSawTooltip() {
        if isShowTooltip {
            isShowTooltip = false
            UserDefaults.standard.set(true, case: .isUserSawTooltipLongpressInCounterScreen)
        }
    }
}
