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
            HeaderView(name: localStore.name.isEmpty ? "New counter" : localStore.name, color: localStore.color)
            ICTextField(text: $localStore.name, name: "Name", placeholder: "counter name", maxLength: 30)
                .padding([.horizontal, .top], 10)
            
            HStack(alignment: .top, spacing: 30) {
                ICTextField(text: $localStore.description, name: "Name", placeholder: "counter description", lineLimit: 2...6, maxLength: 200)
                colorPicker()
            }.padding([.horizontal, .top], 10)

            Spacer()
        }
        .background(.background1)
    }
    
    @ViewBuilder
    private func colorPicker() -> some View {
        VStack(alignment: .leading) {
            Text("color")
                .font(.system(size: 14))
                .foregroundStyle(.textInfo)
            IconNameView(name: localStore.name, color: localStore.color)
                .modifier(ShadowModifier(foregroundColor: .background1, cornerRadius: 15))
                .frame(width: 66 ,height: 66)
        }
    }
}

#Preview {
    CreateCounterScreen()
}
