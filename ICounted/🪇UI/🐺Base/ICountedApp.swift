//
//  ICountedApp.swift
//  ICounted
//
//  Created by Nebo on 07.07.2024.
//

import SwiftUI

@main
struct ICountedApp: App {
    
    @StateObject var store = AppStore()
    
    var body: some Scene {
        WindowGroup {
            CountersListScreen().environmentObject(store)
                .overlay {
                    if store.state.alert != nil {
                        AlertView(model: store.state.alert!)
                    }
                }
        }
    }
}
