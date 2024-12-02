//
//  CreateCounterScreenStore.swift
//  ICounted
//
//  Created by Nebo on 03.10.2024.
//

import SwiftUI

@Observable
class CreateCounterScreenStore {
    
    var name: String = ""
    var description: String = ""
    var color: Color = .blue
    var startValue: Int = 0
    var isUseTargetValue = false
    var targetCount: Int = 100
    var isAddToWidget = false
    
    func createCounter() -> Counter {
        Counter(name: name, desc: description,
                count: startValue, lastRecord: Date(),
                colorHex: color.toHex() ?? "",
                isFavorite: isAddToWidget,
                targetCount: isUseTargetValue ? targetCount : nil)
    }
}
