//
//  CountersStore.swift
//  ICounted
//
//  Created by Nebo on 01.12.2024.
//

import Foundation

@Observable
class CountersStore: BaseStore {
    
    @ObservationIgnored
    private let localRepository: DBRepositoryProtocol
    
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
    
    func countPlus(counter: Counter, message: String? = nil) {
        Vibration.light.vibrate()
        localRepository.plusCount(counter: counter, message: message)
    }
    
    func favoriteToggle(counter: Counter) {
        localRepository.favoriteToggle(counter: counter)
    }
    
    func deleteCounter(counter: Counter) {
        localRepository.deleteCounter(counter: counter)
        updateAllCounters()
    }
    
    func deleteRecord(record: CounterRecord) {
        localRepository.deleteRecord(record: record)
        updateAllCounters()
    }
}
