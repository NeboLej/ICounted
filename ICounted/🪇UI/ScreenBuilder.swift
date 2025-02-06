//
//  ScreenBuilder.swift
//  ICounted
//
//  Created by Nebo on 01.12.2024.
//

import Foundation
import SwiftUI

enum Screen {
    case counterList
    case counter(Counter)
    case createCounter
    case editCounter(Counter)
    case settings
}

enum Component {
    case counterCell(Counter)
    case messageRecordInput(Counter, Binding<Bool>)
}

class ScreenBuilder {
    
    static let shared = ScreenBuilder(countersStore: CountersStore(localRepository: DBRepositoryMock()), settingsStore: SettingStore())
    
    var countersStore: CountersStore
    var settingsStore: SettingStore
    
    init(countersStore: CountersStore, settingsStore: SettingStore) {
        self.countersStore = countersStore
        self.settingsStore = settingsStore
    }
    
    @ViewBuilder
    func getScreen(screenType: Screen) -> some View {
        switch screenType {
        case .counterList:
            CountersListScreen()
                .environment(\.countersStore, countersStore)
                .environment(\.screenBuilder, self)
        case .counter(let counter):
            CounterScreen(counter: counter)
                .environment(\.countersStore, countersStore)
                .environment(\.screenBuilder, self)
        case .createCounter:
            CreateCounterScreen()
                .environment(\.countersStore, countersStore)
        case .editCounter(let counter):
            EditCounterScreen(counter: counter)
                .environment(\.countersStore, countersStore)
                .environment(\.screenBuilder, self)
        case .settings:
            SettingsScreen()
                .environment(\.settingsStore, settingsStore)
        }
    }
    
    @ViewBuilder
    func getComponent(componentType: Component) -> some View {
        switch componentType {
        case .counterCell(let counter):
            CounterCell(counter: counter)
                .environment(\.countersStore, countersStore)
        case .messageRecordInput(let counter, let isShow):
            ICMessageRecordInput(counter: counter, isShow: isShow)
                .environment(\.countersStore, countersStore)
        }
    }
}

