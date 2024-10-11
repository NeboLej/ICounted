//
//  AppReducer.swift
//  ICounted
//
//  Created by Nebo on 07.07.2024.
//

import Foundation

func reducer(state: AppState, action: AppAction) -> AppState {
    var state = state
    var counters = state.counters
    
    switch action {
    case .countPlus(counterId: let id):
        if let counterIndex = counters.firstIndex(where: { $0.id == id }) {
            let counter = counters[counterIndex]
            counters[counterIndex] = counter.copy(count: counter.count + 1)
            state.counters = counters
        }
        
    case .countMinus(counterId: let id):
        if let counterIndex = counters.firstIndex(where: { $0.id == id }) {
            let counter = counters[counterIndex]
            let newCount = counter.count - 1
            counters[counterIndex] = counter.copy(count: newCount >= 0 ? newCount :  counter.count)
            state.counters = counters
        }
        
    case .toggleIsFavorite(counterId: let id):
        if let counterIndex = counters.firstIndex(where: { $0.id == id }) {
            let counter = counters[counterIndex]
            counters[counterIndex] = counter.copy(isFavorite: !counter.isFavorite)
            state.counters = counters
        }
        
    case .addCounter(counter: let counter):
        state.counters.append(counter)
        
    case .deleteCounter(counterId: let id):
        counters.removeAll(where: { $0.id == id })
        state.counters = counters
    }
    
    
    return state
}

