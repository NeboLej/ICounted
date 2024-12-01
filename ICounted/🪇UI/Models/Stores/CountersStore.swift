//
//  CountersStore.swift
//  ICounted
//
//  Created by Nebo on 01.12.2024.
//

import Foundation

@Observable
class CountersStore: BaseStore {
    
    @ObservationIgnored let localRepository: DBRepositoryProtocol
    var counterList: [Counter] = []
    var allCount: Int {
        counterList.reduce(0) { $0 + $1.count }
    }
    
    init(localRepository: DBRepositoryProtocol) {
        self.localRepository = localRepository
        super.init()
        
        updateAllCounters()
    }
    
    func saveCounter(newCounter: Counter) {
        localRepository.saveCounter(newCounter: newCounter)
        updateAllCounters()
    }
    
    func updateAllCounters() {
        counterList = localRepository.getAllCounters()
    }
    
}

import SwiftUI

struct StoreKey: EnvironmentKey {
    static var defaultValue = CountersStore(localRepository: DBRepositoryMock())
}

extension EnvironmentValues {
    var countersStore: CountersStore {
        get { self[StoreKey.self] }
        set { self[StoreKey.self] = newValue }
    }
}

//struct ContentView: View {
//    @Environment(\.store) var store // Внедряем через окружение в представлении
//    var body: some View {
//       ...
//    }
//}
