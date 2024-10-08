//
//  CounterScreenStore.swift
//  ICounted
//
//  Created by Nebo on 06.10.2024.
//

import SwiftUI

class CounterScreenStore: ObservableObject {
    
    @Published var name: String = ""
    @Published var description: String = ""
    @Published var color: Color = .blue
    @Published var count: Int = 0
    @Published var isUseTargetValue = false
    @Published var targetCount: Int = 0
    @Published var isAddToWidget = false
    @Published var progress: Double = 0
    var id: UUID?
    
    func bindCounter(counter: Counter) {
        id = counter.id
        name = counter.name
        description = counter.description
        color = Color(hex: counter.colorHex)
        count = counter.count
        isUseTargetValue = counter.taggetCount != nil
        targetCount =  counter.taggetCount != nil ?  counter.taggetCount! : 0
        isAddToWidget = counter.isFavorite
        
        progress = getProgress()
    }
    
    private func getProgress() -> Double {
        if targetCount == 0 { return 1 }
        return (100 / Double(targetCount)) * Double(count)
    }
}
