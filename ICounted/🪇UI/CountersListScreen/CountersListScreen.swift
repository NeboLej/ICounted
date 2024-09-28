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

var TEST: AppStore = AppStore(state: AppState(counters: [
    Counter(name: "Smoked some cigarettes ",
            description: "how much have I smoked since winter sad sds da d dsfds fsd fsd fs fs f dsabsmndb as dabs djhbasf wf we fewf  qwdwqd qdzd as jsnkadjnakj ndkajsnd kaskd absdan dkjasn dkanskd jnak",
            count: 20,
            lastRecord: Date(),
            colorHex: "04a6d9",
            isFavorites: true,
            taggetCount: nil),
    
    Counter(name: "Walking the dog",
            description: "",
            count: 104,
            lastRecord: Date(),
            colorHex: "ea9171",
            isFavorites: false,
            taggetCount: nil),
    
    Counter(name: "Jog in the mornings",
            description: "run 30 times and evaluate the result",
            count: 777,
            lastRecord: Date(),
            colorHex: "043464",
            isFavorites: true,
            taggetCount: nil),
    
]))
