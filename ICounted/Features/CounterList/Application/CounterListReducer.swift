//
//  CounterListReducer.swift
//  ICounted
//
//  Created by Nebo on 29.10.2024.
//

import Foundation

func counterListReducer(_ state: inout CounterListState, action: CounterListAction) {
 
    switch action {
    case .countersLoaded(let counters):
        state.counters = counters
    case .showAlert(let alert):
        state.alert = alert
    case .moveToScreen(let screen):
        state.screen = screen
        
    //middleware
    case .loadCounters: break
    case .countPlus: break
    case .deleteCounter: break
    case .addCounter: break
    case .toggleIsFavorite:break
    case .countMinus: break
    }
}
