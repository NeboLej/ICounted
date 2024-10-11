//
//  AppAction.swift
//  ICounted
//
//  Created by Nebo on 07.07.2024.
//

import Foundation

enum AppAction {
    case countPlus(counterId: UUID)
    case countMinus(counterId: UUID)
    case toggleIsFavorite(counterId: UUID)
    case addCounter(counter: Counter)
    case deleteCounter(counterId: UUID)
}
