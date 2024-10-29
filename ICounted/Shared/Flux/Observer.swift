//
//  Observer.swift
//  ICounted
//
//  Created by Nebo on 29.10.2024.
//

import Foundation

enum ObserverStatus {
    case alive
    case dead
}

final class Observer<State> {
//    private let observeBlock: (State) -> ObserverStatus
    let queue: DispatchQueue
    let observe: (State) -> ObserverStatus

    init(queue: DispatchQueue = .main,
         observe: @escaping (State) -> ObserverStatus) {
        self.queue = queue
        self.observe = observe
    }

//    func observe(_ state: State) -> ObserverStatus {
//        return observeBlock(state)
//    }
}

extension Observer: Hashable {
    static func == (lhs: Observer<State>, rhs: Observer<State>) -> Bool {
        return lhs === rhs
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
}
