//
//  ICounterWidget.swift
//  ICounterWidget
//
//  Created by Nebo on 25.01.2025.
//

import WidgetKit
import SwiftUI
import SwiftData


struct ICounterWidget: Widget {
    let kind: String = "ICounterWidget"
    
    private let modelCountainer = sharedModelContainer
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: ICounterProvider(modelContainer: modelCountainer)) { entry in
            if #available(iOS 17.0, *) {
                ICounterWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                ICounterWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct ICounterProvider: TimelineProvider {
    
    private let modelContainer: ModelContainer
    
    init(modelContainer: ModelContainer) {
        self.modelContainer = modelContainer
    }
    
    func getSnapshot(in context: Context, completion: @escaping @Sendable (CounterEntry) -> Void) {
        completion(
            CounterEntry(date: Date(), counter: Counter(name: "Asdf", desc: "sdfsdf", count: 12, lastRecord: Date(), colorHex: "DAF226", isFavorite: true, targetCount: 100))
        )
    }
    
    func placeholder(in context: Context) -> CounterEntry {
        CounterEntry(date: Date(), counter: Counter(name: "Asdf", desc: "sdfsdf", count: 12, lastRecord: Date(), colorHex: "DAF226", isFavorite: true, targetCount: 100))
    }
    
//    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> CounterEntry {
//        CounterEntry(date: Date(), counter: Counter(name: "Asdf", desc: "sdfsdf", count: 12, lastRecord: Date(), colorHex: "DAF226", isFavorite: true, targetCount: 100))
//    }
    
    func getTimeline(in context: Context, completion: @escaping @Sendable (Timeline<CounterEntry>) -> Void) {
        Task { @MainActor in
            var entries: [CounterEntry] = []
            let currentDate = Date()
            let context = sharedModelContainer.mainContext
            
            let counters = (try? context.fetch(FetchDescriptor<Counter>())) ?? []
            entries = counters.map {
                CounterEntry(date: currentDate, counter: $0)
            }
            
            let timeline = Timeline(entries: entries, policy: .atEnd)
            completion(timeline)
        }
    }
}


struct CounterEntry: TimelineEntry {
    let date: Date
    let counter: Counter
}

struct ICounterWidgetEntryView : View {
    var entry: ICounterProvider.Entry
    
    @Environment(\.widgetFamily) var family
    
    var body: some View {
        switch family {
        case .systemSmall:
            smallWidget()
        default:
            Text(entry.counter.name)
        }
    }
    
    @ViewBuilder private func smallWidget() -> some View {
        VStack {
            Text(entry.counter.name)
                .multilineTextAlignment(.leading)
            
            Spacer()
            CounterValueView(count: entry.counter.count)
            Spacer()
            countButton()
        }
        
    }
    
    @ViewBuilder
    private func countButton() -> some View {
        Button(intent: NothingAction()) {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(hex: entry.counter.colorHex))
                .modifier(ShadowModifier(foregroundColor: .black, cornerRadius: 16))
                .frame(width: 120, height: 32)
                .overlay {
                    Text("count")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundStyle(.textDark)
                }
        }
        .buttonStyle(.plain)
    }
}


#Preview(as: .systemSmall) {
    ICounterWidget()
} timeline: {
    CounterEntry(date: Date(), counter: Counter(name: "Помыть деда 232 раза", desc: "sdfsdf", count: 12, lastRecord: Date(), colorHex: "FDDD03", isFavorite: true, targetCount: 100))
    //    SimpleEntry(date: .now, configuration: .smiley)
    //    SimpleEntry(date: .now, configuration: .starEyes)
}
