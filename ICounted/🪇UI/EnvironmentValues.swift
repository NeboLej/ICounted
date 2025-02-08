//
//  EnvironmentValues.swift
//  ICounted
//
//  Created by Nebo on 01.12.2024.
//

import Foundation
import SwiftUI

struct ScreenBuilderKey: EnvironmentKey {
    static var defaultValue = ScreenBuilder(countersStore: CountersStore(localRepository: DBRepositoryMock()), settingsStore: SettingStore())
}

struct CountersStoreKey: EnvironmentKey {
    static var defaultValue = CountersStore(localRepository: DBRepositoryMock())
}

struct SettingStoreKey: EnvironmentKey {
    static var defaultValue = SettingStore()
}

extension EnvironmentValues {
    var screenBuilder: ScreenBuilder {
        get { self[ScreenBuilderKey.self] }
        set { self[ScreenBuilderKey.self] = newValue }
    }
    
    var countersStore: CountersStore {
        get { self[CountersStoreKey.self] }
        set { self[CountersStoreKey.self] = newValue }
    }
    
    var settingsStore: SettingStore {
        get { self[SettingStoreKey.self] }
        set { self[SettingStoreKey.self] = newValue }
    }
}
