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
                next(.showAlert(alert: .getErrorModel(message: "Название счетчика не может быть пустым")))
            } else if counter.targetCount == 0 {
                next(.showAlert(alert: .getErrorModel(message: "фоывлфыволфывол")))
            } else {
                next(action)
            }
        default:
            next(action)
        }
    }
    
    
}
