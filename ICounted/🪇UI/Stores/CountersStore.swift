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
    
    var sortType: Settings.SortType = .dateCreate {
        didSet {
            updateAllCounters()
        }
    }
    
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
        let sortType: (Counter, Counter) -> Bool = { (lhs, rhs) -> Bool in
            switch self.sortType {
            case .dateCreate:
                return lhs.dateCreate > rhs.dateCreate
            case .dateRecord:
                guard let lhsDate = lhs.records?.last?.date else { return false }
                guard let rhsDate = rhs.records?.last?.date else { return true }
                return lhsDate > rhsDate
            case .name:
                return lhs.name < rhs.name
            case .recordCount:
                return lhs.count > rhs.count
            }
        }
        
        counterList = localRepository.getAllCounters().sorted(by: sortType)//.sorted(by: { $0.name < $1.name } )
    }
    
    func countPlus(counter: Counter, message: String? = nil, date: Date? = nil) {
        Vibration.light.vibrate()
        localRepository.plusCount(counter: counter, message: message, date: date)
    }
    
    func favoriteToggle(counter: Counter) {
        localRepository.favoriteToggle(counter: counter)
    }
    
    func deleteCounter(counter: Counter) {
        localRepository.deleteCounter(counter: counter)
        updateAllCounters()
    }
    
    func deleteRecord(record: CounterRecord, counter: Counter) {
        localRepository.deleteRecord(record: record, counter: counter)
        updateAllCounters()
    }
}
