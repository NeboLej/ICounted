//
//  CounterListState.swift
//  ICounted
//
//  Created by Nebo on 29.10.2024.
//

import Foundation

enum Screen {
    case counterList, counter, createCounter
}

struct CounterListState: Equatable {
    var counters: [Counter] = []
    var alert: AlertModel? = nil
    var screen: Screen = .counterList
}
