//
//  CounterCell.swift
//  ICounted
//
//  Created by Nebo on 28.09.2024.
//

import SwiftUI

struct CounterCell: View {
    
    @EnvironmentObject var store: AppStore
    let counter: Counter
    
    var body: some View {
        
        ZStack {
            VStack {
                HStack {
                    IconNameView(name: counter.name, color: Color(hex: counter.colorHex))
                        .frame(width: 45, height: 45)
                    VStack(alignment: .leading) {
                        Text(counter.name)
                            .foregroundStyle(.textDark)
                            .font(.system(size: 18))
                            .fontWeight(.semibold)
                        Text(counter.description)
                            .lineLimit(3)
                            .foregroundStyle(.textInfo)
                            .font(.system(size: 14))
                            .fontWeight(.regular)
                    }
                    Spacer()
                    VStack {
                        Image(counter.isFavorite ? .starActive : .star)
                            .onTapGesture {
                                store.dispatch(action: .toggleIsFavorite(counterId: counter.id))
                            }
                        Spacer()
                    }
                }
                
                HStack() {
                    CounterValueView(count: .constant(counter.count))
                    VStack(alignment: .leading)  {
                        Text("last record")
                            .foregroundStyle(.textDark)
                            .font(.system(size: 14))
                            .fontWeight(.regular)
                        Text(counter.lastRecord.toSimpleDate())
                            .foregroundStyle(.textInfo)
                            .font(.system(size: 14))
                            .fontWeight(.regular)
                    }
                    Spacer()
                    VStack {
                        Spacer()
                        Image(systemName: "arrow.2.squarepath")
                            .foregroundStyle(.textInfo)
                            .onTapGesture {
                                store.dispatch(action: .countMinus(counterId: counter.id))
                            }
                    }
                    
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(Color(hex: counter.colorHex))
                        .frame(width: 45)
                        .onTapGesture {
                            store.dispatch(action: .countPlus(counterId: counter.id))
                        }
                        
                }.frame(height: 45)
            }
            .padding(16)
        }
        .background(Color(hex: counter.colorHex).opacity(0.2))
        .modifier(ShadowModifier(foregroundColor: .background1, cornerRadius: 15))
    }
}

#Preview {
    CountersListScreen()
        .environmentObject(TEST)
}

