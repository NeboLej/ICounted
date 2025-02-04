//
//  ICounterWidget.swift
//  ICounterWidget
//
//  Created by Nebo on 25.01.2025.
//

import WidgetKit
import SwiftUI
import SwiftData

struct CountersEntry: TimelineEntry {
    let date: Date
    let counters: [Counter]
}

struct ICounterWidget: Widget {
    let kind: String = "ICounterWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: ICounterProvider()) { entry in
            if #available(iOS 17.0, *) {
                ICounterWidgetView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                ICounterWidgetView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName(Localized.Widget.name)
        .description(Localized.Widget.desctiption)
    }
}

struct ICounterProvider: TimelineProvider {
    
    func getSnapshot(in context: Context, completion: @escaping @Sendable (CountersEntry) -> Void) { //widget Galery
        completion(
            CountersEntry(date: Date(),
                          counters: [
                            Counter(name: Localized.Widget.exapmleName1, desc: "", count: 90, lastRecord: Date(), colorHex: "F58F8F", isFavorite: true, targetCount: 100),
                            Counter(name: Localized.Widget.exapmleName2, desc: "", count: 105, lastRecord: Date(), colorHex: "51D403", isFavorite: true, targetCount: 100),
                            Counter(name: Localized.Widget.exapmleName3, desc: "", count: 12, lastRecord: Date(), colorHex: "FDDD03", isFavorite: true, targetCount: 100),
                            Counter(name: Localized.Widget.exapmleName4, desc: "", count: 26, lastRecord: Date(), colorHex: "53A4F0", isFavorite: true, targetCount: 100),
                          ])
        )
    }
    
    func placeholder(in context: Context) -> CountersEntry {
        CountersEntry(date: Date(), counters: [])
    }
    
    func getTimeline(in context: Context, completion: @escaping @Sendable (Timeline<CountersEntry>) -> Void) {
        Task { @MainActor in
            var entries: [CountersEntry] = []
            let currentDate = Date()
            let context = sharedModelContainer.mainContext
            
            let counters = (try? context.fetch(FetchDescriptor<Counter>()))?.filter { $0.isFavorite } ?? []
            entries = [CountersEntry(date: currentDate, counters: counters)]
            
            let timeline = Timeline(entries: entries, policy: .atEnd)
            completion(timeline)
        }
    }
}
