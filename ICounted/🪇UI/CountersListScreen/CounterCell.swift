//
//  CounterCell.swift
//  ICounted
//
//  Created by Nebo on 28.09.2024.
//

import SwiftUI

struct CounterCell: View {
    
    @Environment(\.countersStore) var countersStore: CountersStore
    
    let counter: Counter
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    ICIconNameView(name: counter.name, color: Color(hex: counter.colorHex))
                        .frame(width: 45, height: 45)
                    VStack(alignment: .leading) {
                        Text(counter.name)
                            .foregroundStyle(.textDark)
                            .font(.system(size: 18))
                            .fontWeight(.semibold)
                        Text(counter.desc)
                            .lineLimit(3)
                            .foregroundStyle(.textInfo)
                            .font(.system(size: 14))
                            .fontWeight(.regular)
                    }
                    Spacer()
                    VStack {
                        Image(counter.isFavorite ? .starActive : .star)
                            .onTapGesture {
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
                    CounterValueView(count: counter.count)
                    if let lastRecord = counter.lastRecord {
                        VStack(alignment: .leading)  {
                            Text("last record")
                                .foregroundStyle(.textDark)
                                .font(.system(size: 14))
                                .fontWeight(.regular)
                            Text(lastRecord.toSimpleDate())
                                .foregroundStyle(.textInfo)
                                .font(.system(size: 14))
                                .fontWeight(.regular)
                        }
                    }
                    
                    Spacer()
                    
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundStyle(Color(hex: counter.colorHex))
                        .frame(width: 80, height: 32)
                        .overlay {
                            Text("count")
                                .font(.system(size: 14))
                        }
                        .onTapGesture {
                            countersStore.countPlus(counter: counter)
                        }
                    
                }.frame(height: 45)
            }
            .padding([.top, .horizontal], 16)
            .padding(.bottom, 12)
        }
        .background(Color(hex: counter.colorHex).opacity(0.2))
        .modifier(ShadowModifier(foregroundColor: .background1, cornerRadius: 15))
    }
    
    
    private func progressBar() -> some View {
        VStack(spacing: 4) {
            HStack {
                Text(String(Int(counter.progress ?? 0)) + "%")
                    .foregroundStyle(.textInfo)
                    .font(.system(size: 12))
                    .fontWeight(.regular)
                Spacer()
                Text(String(counter.targetCount ?? 0))
                    .foregroundStyle(.textInfo)
                    .font(.system(size: 12))
                    .fontWeight(.regular)
            }
            
            ICTextProgressBar(progress: .constant(counter.progress ?? 0))
                .frame(height: 5)
        }
    }
}

#Preview {
    ScreenBuilder.shared.getScreen(screenType: .counterList)
}
