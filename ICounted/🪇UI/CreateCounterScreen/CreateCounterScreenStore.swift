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
}
