//
//  ICountedApp.swift
//  ICounted
//
//  Created by Nebo on 07.07.2024.
//

import SwiftUI

@main
struct ICountedApp: App {
    
    let store = AppStore()
    
    var body: some Scene {
        WindowGroup {
            CountersListScreen().environmentObject(store)
        }
    }
}
