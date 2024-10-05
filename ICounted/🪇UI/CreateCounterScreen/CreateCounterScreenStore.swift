//
//  CreateCounterScreenStore.swift
//  ICounted
//
//  Created by Nebo on 03.10.2024.
//

import SwiftUI

class CreateCounterScreenStore: ObservableObject {
    
    @Published var name: String = ""
    @Published var description: String = ""
    @Published var color: Color = .blue
    @Published var startValue: Int = 0
    @Published var isUseTargetValue = false
    @Published var targetCount: Int = 0
    @Published var isAddToWidget = false
    
    func createCounter() -> Counter {
        Counter(name: name, description: description,
                count: startValue, lastRecord: Date(),
                colorHex: color.toHex() ?? "",
                isFavorite: isAddToWidget,
                taggetCount: isUseTargetValue ? targetCount : nil)
    }
}
