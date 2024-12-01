//
//  CountersListScreen.swift
//  ICounted
//
//  Created by Nebo on 07.07.2024.
//

import SwiftUI

struct CountersListScreen: View {
    
    @State var isShowCounter = false
    @State var isShowCreateCounter = false
    @State var conter: Counter? = nil
    
//    @StateObject var store: Store<CounterListState, CounterListAction>
//    @StateObject var store: Store<CounterListState, CounterListAction>
//    @StateObject var localStore = CounterListScreenStore()
    
    @Environment(CountersStore.self) var countersStore: CountersStore
//    @Environment(\.countersStore) var countersStore
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ScrollView {
                headerView()
                    .padding(.horizontal, 16)
                    .frame(height: 80)
                Spacer(minLength: 30)
                counterList()
                    .padding(.top, 8)
                    .padding(.horizontal, 16)
            }.background(Color.background1)
            
            createCounterButton()
                .frame(width: 54, height: 54)
                .padding(.trailing, 16)
        }
//        .onAppear {
//            store.subscribe(observer: Observer { newState in
//                localStore.updateCountersValue(counters: newState.counters)
//                switch newState.screen {
//                case .counter:
//                    localStore.isShowCounter = true
//                case .createCounter:
//                    localStore.isCreateCounter = true
//                default: break
//                }
//                return .alive
//            })
//        }
        .sheet(isPresented: $isShowCreateCounter, onDismiss: {
//            store.dispatch(.moveToScreen(screen: .counterList))
        }, content: {
            CreateCounterScreen(isShow: $isShowCreateCounter)
                .environment(countersStore)
        })
        .sheet(isPresented: $isShowCounter, onDismiss: {
//            store.dispatch(.moveToScreen(screen: .counterList))
        }, content: {
//            CounterScreen(counter: localStore.selectedCounter)
            if conter != nil {
                CounterScreen(isShow: $isShowCounter, counter: conter!)
                    .environment(countersStore)
            } else {
                EmptyView()
            }
            
        })
    }
    
    @ViewBuilder
    private func headerView() -> some View {
        HStack(spacing: 12) {
            counter()
                .modifier(ShadowModifier(foregroundColor: .background1))
            allCount()
                .modifier(ShadowModifier(foregroundColor: .background1))
            setting()
                .modifier(ShadowModifier(foregroundColor: .background2))
        }
    }
    
    @ViewBuilder
    private func createCounterButton() -> some View {
        Image(systemName: "plus.circle.fill")
            .resizable()
            .foregroundStyle(.background3)
            .modifier(ShadowModifier(foregroundColor: .black, cornerRadius: 27))
            .onTapGesture {
                isShowCreateCounter = true
//                store.dispatch(.moveToScreen(screen: .createCounter))
            }
        
    }
    
    
    @ViewBuilder
    private func counterList() -> some View {
        ForEach(countersStore.counterList) { counter in
            CounterCell(counter: counter)
                .onTapGesture {
//                    localStore.selectedCounter = counter
//                    store.dispatch(.moveToScreen(screen: .counter))
                }
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
            CounterValueView(count: countersStore.counterList.count)
                .padding(.bottom, 2)
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
            CounterValueView(count: countersStore.allCount)
                .padding(.bottom, 2)
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
//
//#Preview {
//    CountersListScreen(store: .init(initial: CounterListState(counters:
//                                                                [.init(name: "asdsd", desc: "asdasdsd", count: 123, lastRecord: nil, colorHex: "95D385", isFavorite: true, targetCount: nil),
//                                                                 .init(name: "assssssOO", desc: "sdasdsddsdsdsd sdasd ", count: 10, lastRecord: Date(), colorHex: "95D385", isFavorite: false, targetCount: 100)
//                                                                ]),
//                                    reducer: counterListReducer))
//}
//
