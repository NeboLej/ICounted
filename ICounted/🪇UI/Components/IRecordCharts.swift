//
//  IRecordCharts.swift
//  ICounted
//
//  Created by Nebo on 02.12.2024.
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
    ICRecordChart(records: .constant([.init(date: Date().prevDay, count: 1),
                            .init(date: Date(), count: 2),
                            .init(date: Date().nextDay, count: 3),
                            .init(date: Date().nextDay, count: 4),
                            .init(date: Date().nextDay, count: 5),
    
    ]))
}
