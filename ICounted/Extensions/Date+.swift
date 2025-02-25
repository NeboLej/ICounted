//
//  Date+.swift
//  ICounted
//
//  Created by Nebo on 28.09.2024.
//

import Foundation

fileprivate let SIMPLE_FMT: DateFormatter = {
    let fmt = DateFormatter()
    fmt.dateFormat = "dd.MM.yyyy"
    return fmt
}()

fileprivate let DATE_FULL_FMT: DateFormatter = {
    let fmt = DateFormatter()
    fmt.dateFormat = "dd MMMM"
    return fmt
}()

fileprivate let DATE_FULL_YEAR_FMT: DateFormatter = {
    let fmt = DateFormatter()
    fmt.dateFormat = "dd MMMM yyyy"
    return fmt
}()

fileprivate let TIME_FMT: DateFormatter = {
    let fmt = DateFormatter()
    fmt.dateFormat = "HH:mm"
    return fmt
}()

extension Date {
    
    var nextDay: Date { Date(timeIntervalSince1970: timeIntervalSince1970 + 60*60*24) }
    var prevDay: Date { Date(timeIntervalSince1970: timeIntervalSince1970 - 60*60*24) }
    
    var nextMonth: Date { Date(timeIntervalSince1970: timeIntervalSince1970 + 60*60*24*31) }
    var prevMonth: Date { Date(timeIntervalSince1970: timeIntervalSince1970 - 60*60*24*31) }
    
    func getOffsetDate(offset: Int) -> Date {
        Calendar.current.date(byAdding: .day, value: offset, to: self) ?? Date()
    }
    
    func toSimpleDate() -> String {
        SIMPLE_FMT.string(from: self)
    }
    
    func toReadableDate() -> String {
        let date = Date()
        if isSameDay(date: date) { return Localized.shared.component.dateToday }
        else if isSameDay(date: date.nextDay) { return Localized.shared.component.dateTomorrow }
        else if isSameDay(date: date.prevDay) { return Localized.shared.component.dateYesterday }
        else { return SIMPLE_FMT.string(from: self) }
    }
    
    func isSameDay(date: Date) -> Bool {
        return Calendar.current.isDate(date, inSameDayAs: self)
    }
    
    func isSameYear(with: Date) -> Bool {
        let comp0 = Calendar.current.dateComponents([.era, .year], from: self)
        let comp1 = Calendar.current.dateComponents([.era, .year], from: with)
        return comp0.era == comp1.era && comp0.year == comp1.year
    }
    
    func getAllDatesForMonth() -> [Date] {
        let calendar = Calendar.current
        let startDate = calendar.date(from: calendar.dateComponents([.year, .month], from: self))!
        let range = calendar.range(of: .day, in: .month, for: startDate)!
        
        return range.compactMap { calendar.date(byAdding: .day, value: $0 - 1, to: startDate)! }
    }
    
    func monthNameShort(locale: Locale = .autoupdatingCurrent) -> String {
        let formatter = DateFormatter()
        formatter.locale = locale
        formatter.dateFormat = "LLL"
        return formatter.string(from: self)
    }
    
    func time() -> String {
        TIME_FMT.string(from: self)
    }
}
