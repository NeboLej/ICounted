//
//  NewCounterValidationMiddleware.swift
//  ICounted
//
//  Created by Nebo on 29.10.2024.
//

import Foundation

struct NewCounterValidationMiddleware: Middleware {
    func process(action: CounterListAction, state: CounterListState, next: @escaping (CounterListAction) -> Void) {
        switch action {
        case .addCounter(let counter):
            if counter.name.isEmpty {
                next(.showAlert(alert: .getErrorModel(message: "Counter name cannot be empty")))
            } else if counter.targetCount == 0 {
                next(.showAlert(alert: .getErrorModel(message: "The target value cannot be zero")))
            } else {
                next(action)
            }
        default:
            next(action)
        }
    }
}
