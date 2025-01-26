//
//  AppIntent.swift
//  ICounterWidget
//
//  Created by Nebo on 25.01.2025.
//

import WidgetKit
import AppIntents
import SwiftData

//struct ConfigurationAppIntent: WidgetConfigurationIntent {
//    static var title: LocalizedStringResource { "Configuration" }
//    static var description: IntentDescription { "This is an example widget." }
//
//    // An example configurable parameter.
//    @Parameter(title: "Favorite Emoji", default: "😃")
//    var favoriteEmoji: String
//}

struct NothingAction: AppIntent {
    
    static var title: LocalizedStringResource = "Do nothing"
    static var description: IntentDescription? = "Not description"
    
    func perform() async throws -> some IntentResult {
        print("asdasdsd")
        return .result()
    }
}
