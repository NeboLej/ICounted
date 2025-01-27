//
//  ICounterWidgetView.swift
//  ICounterWidgetExtension
//
//  Created by Nebo on 26.01.2025.
//

import SwiftUI
import WidgetKit

struct ICounterWidgetView: View {
    
    @Environment(\.widgetFamily) var family
    var entry: ICounterProvider.Entry
    var separatorColor: Color = .gray.opacity(0.5)
    
    var body: some View {
        
        if entry.counters.isEmpty {
            emptyState()
        } else {
            switch family {
            case .systemSmall:
                smallWidget()
            case .systemMedium:
                mediumWidget()
            case .systemLarge:
                largeWidget()
            default:
                smallWidget()
            }
        }
    }

    @ViewBuilder
    private func emptyState() -> some View {
        VStack {
            Text(Localized.Widget.emptyStateDescription)
                .font(.system(size: 14))
                .multilineTextAlignment(.center)
            Image(.starActive)
        }
    }
    
    @ViewBuilder
    private func smallWidget() -> some View {
        if entry.counters.count > 0 {
            counterCell(counter: entry.counters[0])
                .frame(width: 150)
        }
    }
    
    @ViewBuilder
    private func mediumWidget() -> some View {
        HStack {
            if entry.counters.count > 0 {
                counterCell(counter: entry.counters[0])
                    .frame(maxWidth: entry.counters.count == 1 ? .infinity : 150)
            }

            if entry.counters.count > 1 {
                Rectangle()
                    .frame(width: 2)
                    .foregroundStyle(separatorColor)
                counterCell(counter: entry.counters[1])
                    .frame(width: 150)
            }
        }
    }
    
    @ViewBuilder
    private func largeWidget() -> some View {
        VStack {
            HStack {
                if entry.counters.count > 0 {
                    counterCell(counter: entry.counters[0])
                        .frame(maxWidth: entry.counters.count == 1 ? .infinity : 150, maxHeight: 150)
                }
                
                if entry.counters.count > 1 {
                    Rectangle()
                        .frame(width: 2, height: 130)
                        .foregroundStyle(separatorColor)
                    counterCell(counter: entry.counters[1])
                        .frame(maxWidth: 150, maxHeight: 150)
                }
            }
            
            if entry.counters.count > 2 {
                Rectangle()
                    .frame(height: 2)
                    .foregroundStyle(separatorColor)
                    .padding(.vertical, 4)
                
                HStack {
                    counterCell(counter: entry.counters[2])
                        .frame(maxWidth: entry.counters.count == 3 ? .infinity : 150, maxHeight: 150)
                    
                    if entry.counters.count > 3 {
                        Rectangle()
                            .frame(width: 2, height: 130)
                            .foregroundStyle(separatorColor)
                        counterCell(counter: entry.counters[3])
                            .frame(maxWidth: 150, maxHeight: 150)
                    }
                }
            } else {
                Spacer()
            }
        }
    }
    
    @ViewBuilder
    private func counterCell(counter: Counter) -> some View {
        VStack {
            Text(counter.name)
                .font(.system(size: 14))
                .frame(height: 40)
                
            Spacer()
            CounterValueView(count: counter.count)
            Spacer()
            countButton(counter: counter)
        }
    }
    
    @ViewBuilder
    private func countButton(counter: Counter) -> some View {
        Button(intent: PlusCountIntent(counterId: counter.id.uuidString)) {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(hex: counter.colorHex))
                .modifier(ShadowModifier(foregroundColor: .black, cornerRadius: 16))
                .frame(width: 120, height: 32)
                .overlay {
                    Text(Localized.Widget.addCountButton)
                        .font(.system(size: 18, weight: .bold))
                        .foregroundStyle(.textDark)
                }
        }
        .buttonStyle(.plain)
    }
}


#Preview(as: .systemLarge) {
    ICounterWidget()
} timeline: {
    CountersEntry(date: Date(), counters: [
        Counter(name: "Go to a law lecture", desc: "", count: 12, lastRecord: Date(), colorHex: "FDDD03", isFavorite: true, targetCount: 100),
        Counter(name: "Ate burgers", desc: "", count: 105, lastRecord: Date(), colorHex: "51D403", isFavorite: true, targetCount: 100),
        Counter(name: "Met Karl this year", desc: "", count: 26, lastRecord: Date(), colorHex: "53A4F0", isFavorite: true, targetCount: 100),
        Counter(name: "Do the exercises 150 times", desc: "", count: 90, lastRecord: Date(), colorHex: "F58F8F", isFavorite: true, targetCount: 100),
    ])
    //    SimpleEntry(date: .now, configuration: .smiley)
    //    SimpleEntry(date: .now, configuration: .starEyes)
}
