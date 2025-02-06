//
//  CounterListStore.swift
//  ICounted
//
//  Created by Nebo on 06.02.2025.
//

import SwiftUI

@Observable
class CounterListScreenStore {
    
    var isShowTooltip: Bool = false
    
    private var userSawTooltip: Bool { UserDefaults.standard.get(case: .isUserSawTooltipLongpressInCounterListScreen) as? Bool ?? false }
    
    func bindCounterList(counters: [Counter]) {
        isShowTooltip = counters.count == 1 && !userSawTooltip
    }
    
    func didUserSawTooltip() {
        if isShowTooltip {
            isShowTooltip = false
            UserDefaults.standard.set(true, case: .isUserSawTooltipLongpressInCounterListScreen)
        }
    }
}
