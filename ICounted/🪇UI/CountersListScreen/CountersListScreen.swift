//
//  CountersListScreen.swift
//  ICounted
//
//  Created by Nebo on 07.07.2024.
//

import SwiftUI

struct CountersListScreen: View {
    
    @EnvironmentObject var store: AppStore
    @StateObject var localStore = CounterListScreenStore()
    
    
    var body: some View {
        ZStack {
            ScrollView {
                HStack {
                    counter()
                        .modifier(ShadowModifier(foregroundColor: .red))
                    Spacer(minLength: 12)
                    allCount()
                        .modifier(ShadowModifier(foregroundColor: .green))
                    Spacer(minLength: 12)
                    setting()
                        .modifier(ShadowModifier(foregroundColor: .yellow))
                }
                .padding(.horizontal, 16)
                .frame(height: 80)
            }
        }
        .background(Color.yellow.opacity(0.1))
    }
    
    @ViewBuilder
    private func counter() -> some View {
        VStack {
            Text("Counters")
                .font(.custom("", size: 16))
            Rectangle()
                .frame(height: 1)
                .padding(.horizontal, 16)
            CounterValueView(count: $localStore.count)
        }
    }
    @ViewBuilder
    private func allCount() -> some View {
        VStack {
            Text("Count")
                .font(.custom("", size: 16))
            Text("all count + ")
                .font(.custom("", size: 8))
            Rectangle()
                .frame(height: 1)
                .padding(.horizontal, 16)
            CounterValueView(count: $localStore.allCount)
        }
    }
    
    @ViewBuilder
    private func setting() -> some View {
        VStack {
            Image(systemName: "gearshape.fill")
                .foregroundStyle(.blue)
                .padding(.bottom, 3)
            Text("Settings")
                .font(.custom("", size: 16))
        }
    }
}

#Preview {
    CountersListScreen()
}
