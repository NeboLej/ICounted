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
        ScrollView {
            headerView()
                .padding(.horizontal, 16)
                .frame(height: 80)
            Spacer(minLength: 30)
            counterList()
                .padding(.top, 8)
                .padding(.horizontal, 16)
        }.background(Color.background1)
    }
    
    @ViewBuilder
    private func headerView() -> some View {
        HStack {
            counter()
                .modifier(ShadowModifier(foregroundColor: .background1))
            Spacer(minLength: 12)
            allCount()
                .modifier(ShadowModifier(foregroundColor: .background1))
            Spacer(minLength: 12)
            setting()
                .modifier(ShadowModifier(foregroundColor: .background2))
        }
    }
    
    @ViewBuilder
    private func counterList() -> some View {
        ForEach(store.state.counters) {
            CounterCell(counter: $0)
                .environmentObject(store)
        }
    }
    
    @ViewBuilder
    private func counter() -> some View {
        VStack {
            Text("Counters")
                .font(.system(size: 16))
                .foregroundStyle(.textDark)
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
                .font(.system(size: 16))
                .foregroundStyle(.textDark)
            Text("all count + ")
                .font(.system(size: 8))
                .foregroundStyle(.textDark)
            Rectangle()
                .fill(.black)
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
                .font(.system(size: 16))
                .foregroundStyle(.textDark)
        }
    }
    
}

#Preview {
    CountersListScreen()
        .environmentObject(TEST)
}
