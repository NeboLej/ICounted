//
//  CounterCell.swift
//  ICounted
//
//  Created by Nebo on 28.09.2024.
//

import SwiftUI

struct CounterCell: View {
    
    @Environment(\.countersStore) var countersStore: CountersStore
    @State var counter: Counter
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    ICIconNameView(name: counter.name, color: Color(hex: counter.colorHex))
                        .frame(width: 45, height: 45)
                    VStack(alignment: .leading) {
                        Text(counter.name)
                            .foregroundStyle(.textDark)
                            .font(.myFont(type: .bold, size: 18))
                        Text(counter.desc)
                            .lineLimit(4)
                            .foregroundStyle(.textInfo)
                            .font(.myFont(type: .regular, size: 14))
                            .lineSpacing(4)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    Spacer()
                    VStack {
                        Image(counter.isFavorite ? .starActive : .star)
                            .resizable()
                            .frame(width: 34, height: 30).onTapGesture {
                                countersStore.favoriteToggle(counter: counter)
                            }
                        Spacer()
                    }
                }
                
                if counter.targetCount != nil {
                    progressBar()
                        .padding(.top, 16)
                        .padding(.bottom, 8)
                }
                
                HStack {
                    ZStack {
                        if let progress = counter.progress, progress >= 100 {
                            fire()
                                .offset(y: -20)
                        }
                        CounterValueView(count: counter.count)
                    }
                    if let lastRecord = counter.records?.last?.date {
                        VStack(alignment: .leading)  {
                            Text(Localized.CounterCell.lastRecord)
                                .foregroundStyle(.textDark)
                                .font(.myFont(type: .regular, size: 14))
                            Text(lastRecord.toSimpleDate())
                                .foregroundStyle(.textInfo)
                                .font(.myFont(type: .regular, size: 14))
                        }
                    }
                    
                    Spacer()
                    
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundStyle(Color(hex: counter.colorHex))
                        .frame(width: 80, height: 32)
                        .overlay {
                            Text(Localized.CounterCell.addCountButton)
                                .font(.myFont(type: .regular, size: 14))
                        }
                        .onTapGesture {
                            countersStore.countPlus(counter: counter)
                        }
                    
                }
                .frame(height: 45)
                .padding(.top, 8)
            }
            .padding([.top, .horizontal], 16)
            .padding(.bottom, 12)
        }
        .background(Color(hex: counter.colorHex).opacity(0.2))
        .modifier(ShadowModifier(foregroundColor: .background1, cornerRadius: 15))
        .onChange(of: countersStore.allCount) {
            guard let counter = countersStore.counterList.first(where: { $0.id == counter.id }) else { return }
            self.counter = counter
        }
    }
    
    
    @ViewBuilder
    private func fire() -> some View {
        HStack(spacing: 0) {
            ForEach(0...String(counter.count).count/2, id: \.self) { _ in
                Image(.fire)
                    .resizable()
                    .frame(width: 30, height: 30)
            }
        }
    }
    
    
    
    @ViewBuilder
    private func progressBar() -> some View {
        VStack(spacing: 4) {
            HStack {
                Text(String(format: "%.1f", counter.progress ?? 0) + "%")
                    .foregroundStyle(.textInfo)
                    .font(.myFont(type: .regular, size: 12))
                Spacer()
                Text(String(counter.targetCount ?? 0))
                    .foregroundStyle(.textInfo)
                    .font(.myFont(type: .regular, size: 12))
            }
            
            ICTextProgressBar(progress: .constant(counter.progress ?? 0), color: .constant(Color(hex: counter.colorHex)))
                .frame(height: 5)
        }
    }
}

#Preview {
//    ScreenBuilder.shared.getScreen(screenType: .counterList)
    ScreenBuilder.shared.getComponent(componentType: .counterCell(Counter(name: "wdsa", desc: "некий текст не маленького размера чтобы можно было все видеть", count: 11222, lastRecord: Date(), colorHex: "FDC356", isFavorite: true, targetCount: 200)))
        .frame(height: 200)
}
