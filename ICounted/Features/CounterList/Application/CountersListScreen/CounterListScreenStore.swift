//
//  CounterListScreenStore.swift
//  ICounted
//
//  Created by Nebo on 07.07.2024.
//

import Foundation
import Combine

class CounterListScreenStore: ObservableObject {
    
    @Published var count: Int = 55
    @Published var allCount: Int = 448
    
    @Published var isCreateCounter: Bool = false
    @Published var isShowCounter: Bool = false
    var selectedCounter: Counter!
    
//    func createCounter() {
//        isCreateCounter = true
//    }
    
//    func showCounter(counter: Counter) {
//        selectedCounter = counter
//    }
    
//    var cancel = Set<AnyCancellable>()
//    
//    init() {
//        
//        $count.sink { [weak self] coun in
//            self?.ffCount = String(coun).map { String($0) }
//        }.store(in: &cancel)
//        
//    }
    
}
