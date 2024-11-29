//
//  ICRecordChart.swift
//  ICounted
//
//  Created by Nebo on 20.11.2024.
//

import SwiftUI
import Charts

struct CounterStat: Identifiable {
    let id: String = UUID().uuidString
    let date: Date
    let count: Int
}

struct ICRecordChart: View {
    
    @Binding var records: [CounterStat]
    
    var body: some View {
        Chart(records) { element in
            LineMark(x: .value("Day", element.date, unit: .day),
                    y: .value("Value", element.count))
        }
        .padding()
    }
}

#Preview {
    ICRecordChart(records: .constant([.init(date: Date(), count: 1), .init(date: Date().nextDay, count: 2)]))
}


//#Preview {
//    CounterScreen(store:  Store(
//        initial: CounterListState(),
//        reducer: counterListReducer,
//        middleware: [
//            AnyMiddleware(NewCounterValidationMiddleware())
//        ]
//    ), isShow: .constant(true), counter: Counter(name: "asd", desc: "amsdmsak dam da ", count: 222, lastRecord: Date(), colorHex: "142941", isFavorite: true, targetCount: nil))
//}
