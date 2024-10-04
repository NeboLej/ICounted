//
//  CreateCounterScreen.swift
//  ICounted
//
//  Created by Nebo on 03.10.2024.
//

import SwiftUI

struct CreateCounterScreen: View {
    
    @EnvironmentObject var store: AppStore
    @StateObject var localStore = CreateCounterScreenStore()
    
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
                }.padding(.top , 20)
                
                Rectangle()
                    .foregroundStyle(.separatorColor1)
                    .frame(height: 1)
                
            }.padding(.horizontal, 16)
            
            Spacer()
        }
        .background(.background1)
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
}

#Preview {
    CreateCounterScreen()
}
