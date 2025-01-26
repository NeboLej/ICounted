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
    
//    init() {
//        modelCountainer = sharedModelContainer
////        let schema = Schema([Counter.self, CounterRecord.self])
////        let config = ModelConfiguration(schema: schema, cloudKitDatabase: .automatic)
////        let container = try! ModelContainer(for: schema, configurations: config)
////        
////        let dataBase: DBRepository = DBRepository(context: container.mainContext)
////        let localRepository: DBRepositoryProtocol = DBCounterRepository(swiftDataDB: dataBase)
////        
////        countersStore = CountersStore(localRepository: localRepository)
//    }
    
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
//        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: ICounterProvider(countersStore: countersStore)) { entry in
//            ICounterWidgetEntryView(entry: entry, countersStore: countersStore)
//                .containerBackground(.fill.tertiary, for: .widget)
//        }
    }
}

//struct Provider: AppIntentTimelineProvider {
//    
//    func placeholder(in context: Context) -> SimpleEntry {
//        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent())
//    }
//    
//    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
//        SimpleEntry(date: Date(), configuration: configuration)
//    }
//    
//    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
//        var entries: [SimpleEntry] = []
//        
//        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
//        let currentDate = Date()
//        for hourOffset in 0 ..< 5 {
//            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
//            let entry = SimpleEntry(date: entryDate, configuration: configuration)
//            entries.append(entry)
//        }
//        
//        return Timeline(entries: entries, policy: .atEnd)
//    }
//    
//    //    func relevances() async -> WidgetRelevances<ConfigurationAppIntent> {
//    //        // Generate a list containing the contexts this widget is relevant in.
//    //    }
//}

struct ICounterProvider: TimelineProvider {
    func getSnapshot(in context: Context, completion: @escaping @Sendable (CounterEntry) -> Void) {
        completion(
            CounterEntry(date: Date(), counter: Counter(name: "Asdf", desc: "sdfsdf", count: 12, lastRecord: Date(), colorHex: "DAF226", isFavorite: true, targetCount: 100))
        )
    }
    
    private let modelContainer: ModelContainer
    
    init(modelContainer: ModelContainer) {
        self.modelContainer = modelContainer
    }
    
    func placeholder(in context: Context) -> CounterEntry {
        CounterEntry(date: Date(), counter: Counter(name: "Asdf", desc: "sdfsdf", count: 12, lastRecord: Date(), colorHex: "DAF226", isFavorite: true, targetCount: 100))
    }
    
    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> CounterEntry {
        CounterEntry(date: Date(), counter: Counter(name: "Asdf", desc: "sdfsdf", count: 12, lastRecord: Date(), colorHex: "DAF226", isFavorite: true, targetCount: 100))
    }
    
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
        
        
        
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        
//        for hourOffset in 0 ..< 5 {
//            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
//            let entry = CounterEntry(date: entryDate, counter: Counter(name: "Помыть деда", desc: "sdfsdf", count: 12, lastRecord: Date(), colorHex: "DAF226", isFavorite: true, targetCount: 100))
//            entries.append(entry)
//        }
        
//        let counter = modelContainer.
//        let entry = CounterEntry(date: currentDate, counter: counter ?? Counter(name: "Помыть деда", desc: "sdfsdf", count: 12, lastRecord: Date(), colorHex: "DAF226", isFavorite: true, targetCount: 100))
//        
//        return Timeline(entries: [entry], policy: .atEnd)
    }
    
    //    func relevances() async -> WidgetRelevances<ConfigurationAppIntent> {
    //        // Generate a list containing the contexts this widget is relevant in.
    //    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
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

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}

#Preview(as: .systemSmall) {
    ICounterWidget()
} timeline: {
    CounterEntry(date: Date(), counter: Counter(name: "Помыть деда 232 раза", desc: "sdfsdf", count: 12, lastRecord: Date(), colorHex: "FDDD03", isFavorite: true, targetCount: 100))
    //    SimpleEntry(date: .now, configuration: .smiley)
    //    SimpleEntry(date: .now, configuration: .starEyes)
}


import AppIntents
import SwiftData

struct NothingAction: AppIntent {
    
    static var title: LocalizedStringResource = "Do nothing"
    static var description: IntentDescription? = "Not description"
    
    func perform() async throws -> some IntentResult {
        print("asdasdsd")
        return .result()
    }
}
