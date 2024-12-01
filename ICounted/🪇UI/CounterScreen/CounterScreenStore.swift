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
        records = counter.records ?? []
        
        progress = getProgress()
    }
    
    private func getProgress() -> Double {
        if targetCount == 0 { return 1 }
        return (100 / Double(targetCount)) * Double(count)
    }
    
    func showAlert(positiveAction: @escaping ()->(), negativeAction: @escaping ()->()) {
        alert = AlertModel(type: .warning, title: "", message: "Delete the counter \"\(name)\" and the entire history of records without the possibility of recovery??", actions: [.init(name: "delete", completion: positiveAction), .init(name: "cancel", completion: negativeAction)])
    }
}
