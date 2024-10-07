//
//  CounterScreen.swift
//  ICounted
//
//  Created by Nebo on 06.10.2024.
//

import SwiftUI

struct CounterScreen: View {
    
    @EnvironmentObject var store: AppStore
    @StateObject var localStore = CounterScreenStore()
    @Binding var isShow: Bool
    var counter: Counter
    
    
    var body: some View {
        VStack {
            ICHeaderView(name: localStore.name, color: localStore.color)
            
            Group {
                 ICTextField(text: $localStore.name, name: "Name", placeholder: "counter name", maxLength: 30, isEnabled: false)
                     .padding(.top, 10)
                 
                 HStack(alignment: .top, spacing: 24) {
                     ICTextField(text: $localStore.description, name: "Description", placeholder: "counter description", lineLimit: 2...6, maxLength: 200, isEnabled: false)
                     colorPicker()
                 }.padding(.top, 10)
                 
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
                 
                 HStack {
                     ICToggleControlView(isOn: $localStore.isAddToWidget, color: localStore.color, isEnabled: false)
                     Text("add to widget")
                     Spacer()
                 }.padding(.top, 16)
            }.padding(.horizontal, 16)
            
            Spacer()
            
        }
        .background(.background1)
        .onAppear {
            localStore.bindCounter(counter: counter)
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
    CounterScreen(isShow: .constant(true), counter: Counter(name: "Counter", description: "bla bla bla ", count: 123, lastRecord: Date(), colorHex: "043464", isFavorite: true, taggetCount: 500))
}
