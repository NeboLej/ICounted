//
//  WSCalendarView.swift
//  WaterSeven
//
//  Created by Nebo on 29.10.2022.
//

import SwiftUI

#Preview {
    @Previewable @State var selectedDate: Date?
    
    ICCalendarChart(recordsDate: [Date(), Date().prevMonth,Date().prevDay, Date().nextMonth],
                    selectedDate: $selectedDate)
}

struct ICCalendarChart: View {
    
    private let columns = Array(repeating: GridItem(.flexible(minimum: 19, maximum: 20)), count: 7)
    private let days = Calendar.current.shortWeekdaySymbols
    
    @State var recordsDate: [Date] = [Date(), Date().prevMonth]
    @Binding var selectedDate: Date?
    
    var body: some View {
        HStack(alignment: .center, spacing: 4) {
            VStack(alignment: .leading, spacing: 8) {
                ForEach(days, id: \.self) { day in
                    Text(day)
                }
            }.padding(.top, 25)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(getMonths(dates: recordsDate), id: \.self) { date in
                        monthView(month: date)
                    }
                }
            }
        }
    }
    
    
    @ViewBuilder
    private func monthView(month: Date) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(monthName(date: month))
            LazyHGrid(rows: columns, alignment: .center, spacing: 2, pinnedViews: .sectionHeaders) {
                ForEach(extractDate(month: month)) {
                    dateCell(model: $0)
                }
            }.frame(height: 25 * 7 + 6 * 4)
        }
    }
    
    func monthName(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "LLL"
        return formatter.string(from: date)
    }
    
    @ViewBuilder
    private func dateCell(model: WSDateModel) -> some View {
        ZStack {
            if model.day != -1 {
                RoundedRectangle(cornerRadius: 4)
                    .fill(fillCell(date: model.date))
                    .overlay {
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(style: .init(lineWidth: model.date.isSameDay(date: Date()) ? 2 : 0))
                            .foregroundStyle(.red)
                    }
            }
        }
        .frame(width: 25, height: 25)
        .onTapGesture {
            selectedDate = model.date
        }
    }
    
    private func fillCell(date: Date) -> Color {
        var color: Color = .gray.opacity(0.5)
        
        if recordsDate.first(where: { $0.isSameDay(date: date) }) != nil {
            color = Color(.green)
        }
        
        if let selectedDate, date.isSameDay(date: selectedDate) {
            color = Color(.blue)
        }
        
        return color
    }

    
    private func getMonths(dates: [Date]) -> [Date] {
        var monthsSet = Set<DateComponents>()
        dates.forEach {
            let date = Calendar.current.dateComponents([.month, .year], from: $0)
            monthsSet.insert(date)
        }
        return monthsSet.compactMap { Calendar.current.date(from: $0) }.sorted(by: { $0 < $1 })
    }
    
    func extractDate(month: Date) -> [WSDateModel] {
        let calendar = Calendar.current
        
        var days = month.getAllDates().compactMap {
            return WSDateModel(day: calendar.component(.day, from: $0), date: $0)
        }
        
        let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date() )
        print(firstWeekday)
        if firstWeekday != 1 {
            for _ in 0..<firstWeekday - 1 {
                days.insert(WSDateModel(day: -1, date: Date()), at: 0)
            }
        }
        return days
    }
}

struct WSDateModel: Identifiable {
    var id = UUID().uuidString
    var day: Int
    var date: Date
}


extension Date {
    
    func getAllDates() -> [Date] {
        
        let calendar = Calendar.current
        let startDate = calendar.date(from: calendar.dateComponents([.year, .month], from: self))!
        let range = calendar.range(of: .day, in: .month, for: startDate)!
        
        return range.compactMap { calendar.date(byAdding: .day, value: $0 - 1, to: startDate)! }
    }
    
    func isSameDay(date: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(date, inSameDayAs: self)
    }
    
}
