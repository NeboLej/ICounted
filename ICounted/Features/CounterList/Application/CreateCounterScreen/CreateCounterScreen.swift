//
//  CreateCounterScreen.swift
//  ICounted
//
//  Created by Nebo on 03.10.2024.
//

import SwiftUI

struct CreateCounterScreen: View {
    
    @StateObject var store: Store<CounterListState, CounterListAction>
    @StateObject private var localStore = CreateCounterScreenStore()
    @Binding var isShow: Bool
    
    var body: some View {
        VStack {
            ICHeaderView(name: localStore.name.isEmpty ? "New counter" : localStore.name, color: localStore.color)
            
            Group {
                ICTextField(text: $localStore.name, name: "Name", placeholder: "counter name", maxLength: 30)
                    .padding(.top, 10)
                
                HStack(alignment: .top, spacing: 24) {
                    ICTextField(text: $localStore.description, name: "Description", placeholder: "counter description", lineLimit: 2...6, maxLength: 200)
                    colorPicker()
                }.padding(.top, 10)
                                
                HStack {
                    ICNumberSetterView(number: $localStore.startValue)
                    Spacer()
                    Text("starting value")
                        .font(.system(size: 14))
                        .foregroundStyle(.textInfo)
                }.padding(.vertical , 20)
                
                separator()
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("use target value")
                            .font(.system(size: 14))
                            .foregroundStyle(.textInfo)
                        ICToggleControlView(isOn: $localStore.isUseTargetValue, color: localStore.color)
                    }.padding(.vertical, 2)
                   
                   
                    Spacer()
                    if localStore.isUseTargetValue {
                        ICNumberSetterView(number: $localStore.targetCount)
                    }
                }.padding(.vertical , 20)
                
                separator()
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("add to widget")
                            .font(.system(size: 14))
                            .foregroundStyle(.textInfo)
                        ICToggleControlView(isOn: $localStore.isAddToWidget, color: localStore.color)
                    }
                    Spacer()
                }.padding(.vertical , 20)
                
            }.padding(.horizontal, 16)
            
            
            Spacer()
            saveButton()
            
        }
        .background(.background1)
        .modifier(AlertModifier(store: store))
        .onAppear {
            store.subscribe(observer: Observer { newState in
                switch newState.screen {
                case .counterList:
                    isShow = false
                default: break
                }
                return .alive
            })
        }
        
    }
    
    @ViewBuilder
    private func saveButton() -> some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(localStore.color)
            .modifier(ShadowModifier(foregroundColor: .black, cornerRadius: 20))
            .frame(width: 220, height: 48)
            .overlay {
                Text("SAVE")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundStyle(.textDark)
            }
            .onTapGesture {
                store.dispatch(.addCounter(counter: localStore.createCounter()))
            }
    }
    
    @ViewBuilder
    private func separator() -> some View {
        Rectangle()
            .foregroundStyle(.separatorColor1)
            .frame(height: 1)
    }
    
    @ViewBuilder
    private func colorPicker() -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Color")
                .font(.system(size: 14))
                .foregroundStyle(.textInfo)
            
            ZStack(alignment: .topTrailing) {
                ICIconNameView(name: localStore.name, color: localStore.color)
                    .modifier(ShadowModifier(foregroundColor: .background1, cornerRadius: 15, lineWidth: 1))
                    .frame(width: 68, height: 68)
                ColorPicker("", selection: $localStore.color, supportsOpacity: false)
                    .frame(width: 25, height: 25)
            }
            
        }
    }
}

//#Preview {
//    CreateCounterScreen(isShow: .constant(true))
//}
