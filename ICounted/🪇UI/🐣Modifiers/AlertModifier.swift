//
//  AlertModifier.swift
//  ICounted
//
//  Created by Nebo on 13.10.2024.
//

import SwiftUI

struct AlertModifier: ViewModifier {
    
    var alert: AlertModel?
//    @StateObject var store: Store<CounterListState, CounterListAction>
    
    func body(content: Content) -> some View {
        ZStack {
            content
            if alert != nil {
                AlertView(model: alert!)
            }
        }
    }
}
