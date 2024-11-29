//
//  CounterScreen.swift
//  ICounted
//
//  Created by Nebo on 06.10.2024.
//

import SwiftUI

struct CounterScreen: View {
    
    @StateObject var store: Store<CounterListState, CounterListAction>
    @StateObject var localStore = CounterScreenStore()
    @Binding var isShow: Bool
    var counter: Counter
    
    @State private var isShowMenu: Bool = false
    
    var body: some View {
        VStack(spacing: 16) {
            ICHeaderView(name: localStore.name, color: localStore.color)
            
            ScrollView(.vertical) {
                VStack(spacing: 16) {
                    isFavoriteView()
                    descriptionView()
                    counterProgressView()
                    graph()
                        .padding(.top, 30)
                }.padding(.horizontal, 16)
            }
            
            HStack {
                menu()
                Spacer()
                countButton()
            }.padding(.horizontal, 16)
        }
        .background(.background1)
        .onAppear {
            localStore.bindCounter(counter: counter)
            
            store.subscribe(observer: Observer { newState in
                if let counter = newState.counters.first(where: { $0.id == counter.id }) {
                    localStore.bindCounter(counter: counter)
                }
                
                switch newState.screen {
                case .counterList: isShow = false
                    return .dead
                default: break
                }
                return .alive
            })
        }
        .onChange(of: store.state.counters) {
            guard let counter = store.state.counters.first(where: { $0.id == counter.id }) else { return }
            localStore.bindCounter(counter: counter)
        }
        .modifier(AlertModifier(store: store))
    }
    
    @ViewBuilder
    private func isFavoriteView() -> some View  {
        HStack {
            Spacer()
            Text("add to widget")
                .font(.system(size: 14))
                .foregroundStyle(.textInfo)
            Image(localStore.isAddToWidget ? .starActive : .star)
        }
    }
    
    @ViewBuilder
    private func descriptionView() -> some View {
        HStack {
            if !localStore.description.isEmpty {
                Text(localStore.description)
                    .font(.system(size: 16))
                    .foregroundStyle(.textDark)
            }
            Spacer()
        }
    }
    
    @ViewBuilder
    private func counterProgressView() -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text("value")
                    .font(.system(size: 14))
                    .foregroundStyle(.textInfo)
                CounterValueView(count: $localStore.count, width: 20, height: 30)
            }
            
            Spacer()
            
            if localStore.isUseTargetValue {
                VStack(alignment: .trailing) {
                    Text("target value")
                        .font(.system(size: 14))
                        .foregroundStyle(.textInfo)
                    CounterValueView(count: $localStore.targetCount, width: 20, height: 30)
                }
            }
        }.padding(.top, 16)
        
        if localStore.isUseTargetValue {
            progressBar()
                .padding(.top, 16)
        }
    }
    
    @ViewBuilder
    private func countButton() -> some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(localStore.color)
            .modifier(ShadowModifier(foregroundColor: .black, cornerRadius: 20))
            .frame(width: 180, height: 40)
            .overlay {
                Text("count")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundStyle(.textDark)
            }
            .onTapGesture {
                store.dispatch(.countPlus(counterId: counter.id))
            }
    }
    
    @ViewBuilder
    private func menu() -> some View {
        HStack(alignment: .center, spacing: 16) {
            Circle()
                .fill(.background3)
                .overlay {
                    Image(systemName: "ellipsis")
                        .resizable()
                        .frame(width: 20, height:5)
                        .foregroundStyle(.black)
                        .rotationEffect(.degrees(isShowMenu ? 0 : 90))
                }
                .modifier(ShadowModifier(foregroundColor: .background2, cornerRadius: 25))
                .frame(width: 50, height: 50)
                .onTapGesture { isShowMenu.toggle() }
            
            VStack(alignment: .leading, spacing: 10) {
                Text("edit")
                    .font(.system(size: 14))
                    .foregroundStyle(.textDark)
                Text("delete")
                    .font(.system(size: 14))
                    .foregroundStyle(.textDark)
                    .onTapGesture {
                        let alertModel = localStore.showAlert {
                            store.dispatch(.deleteCounter(counterId: counter.id))
                            store.dispatch(.moveToScreen(screen: .counterList))
                        } negativeAction: { }
                        
                        store.dispatch(.showAlert(alert: alertModel))
                    }
            }.opacity(isShowMenu ? 1 : 0)
        }
        .animation(.easeOut(duration: 0.3), value: isShowMenu)
    }
    
    @ViewBuilder
    private func graph() -> some View {
        VStack {
            HStack {
                Text("Count history")
                    .font(.system(size: 14))
                    .foregroundStyle(.textInfo)
                Spacer()
                Group {
                    Image(systemName: "pencil.line")
                        .foregroundStyle(.black)
                    Text("edit history")
                        .font(.system(size: 14))
                        .foregroundStyle(.textDark)
                        .padding(.trailing, 4)
                }.onTapGesture {
                    print("EDIT HISTORY")
                }
            }
            ICRecordChart(records: $localStore.records1)
                .background(localStore.color.opacity(0.1))
                
//            RoundedRectangle(cornerRadius: 16)
//                .fill(localStore.color.opacity(0.1))
                .frame(height: 200)
                .overlay {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(localStore.color, lineWidth: 3)
                    
                   
                }
        }
    }
    
    @ViewBuilder
    private func colorPicker() -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Color")
                .font(.system(size: 14))
                .foregroundStyle(.textInfo)
            ICIconNameView(name: localStore.name, color: localStore.color)
                .modifier(ShadowModifier(foregroundColor: .background1, cornerRadius: 15, lineWidth: 1))
                .frame(width: 68, height: 68)
        }
    }
    
    @ViewBuilder
    private func progressBar() -> some View {
        VStack(alignment: .trailing) {
            Text(String(localStore.progress)+"%")
                .font(.system(size: 14))
                .foregroundStyle(.textInfo)
            ICTextProgressBar(progress: $localStore.progress)
                .frame(height: 10)
        }
    }
    
}

#Preview {
    CounterScreen(store:  Store(
        initial: CounterListState(),
        reducer: counterListReducer,
        middleware: [
            AnyMiddleware(NewCounterValidationMiddleware())
        ]
    ), isShow: .constant(true), counter: Counter(name: "asd", desc: "amsdmsak dam da ", count: 222, lastRecord: Date(), colorHex: "142941", isFavorite: true, targetCount: nil))
}
