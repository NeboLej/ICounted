//
//  ConuterListAction.swift
//  ICounted
//
//  Created by Nebo on 29.10.2024.
//

import Foundation

enum CounterListAction {
    case countPlus(counterId: UUID)
    case countMinus(counterId: UUID)
    case toggleIsFavorite(counterId: UUID)
    case addCounter(counter: Counter)
    case deleteCounter(counterId: UUID)
    case countersLoaded([Counter])
    case loadCounters
    case showAlert(alert: AlertModel)
    case moveToScreen(screen: Screen)
    case dismissAlert
}
