//
//  EditCounterScreen.swift
//  ICounted
//
//  Created by Nebo on 03.02.2025.
//

import SwiftUI

struct EditCounterScreen: View {
    
    @Environment(\.countersStore) var countersStore: CountersStore
    @Environment(\.screenBuilder) var screenBuilder: ScreenBuilder
    @Environment(\.dismiss) var dismiss
    
    @State var counter: Counter
    
    @State private var localStore = EditCounterStore()
    
    var body: some View {
        GeometryReader { _ in
            VStack {
                ICHeaderView(name: localStore.name.isEmpty ? Localized.shared.createCounter.title : localStore.name, color: localStore.color)
                
                Group {
                    ICTextField(text: $localStore.name, name: Localized.shared.createCounter.nameTF, placeholder: Localized.shared.createCounter.nameTFPlaceholder, maxLength: 30)
                        .padding(.top, 10)
                    
                    HStack(alignment: .top, spacing: 24) {
                        ICTextField(text: $localStore.description, name: Localized.shared.createCounter.descriptionTF, placeholder: Localized.shared.createCounter.descriptionTFPlaceholder, lineLimit: 2...6, maxLength: 200)
                        colorPicker()
                    }.padding(.top, 10)
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text(Localized.shared.createCounter.targetValue)
                                .font(.myFont(type: .regular, size: 14))
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
                            Text(Localized.shared.createCounter.toWidget)
                                .font(.myFont(type: .regular, size: 14))
                                .foregroundStyle(.textInfo)
                            ICToggleControlView(isOn: $localStore.isAddToWidget, color: localStore.color)
                        }
                        Spacer()
                    }.padding(.vertical , 20)
                    
                }.padding(.horizontal, 16)
                
                
                Spacer()
                saveButton()
                
            }
        }
        .padding(.bottom, UIDevice.current.userInterfaceIdiom == .pad ? 16 : 0)
        .background(.background1)
        .onAppear {
            localStore.bindCounter(counter: counter)
        }
        .onChange(of: countersStore.allCount) {
            guard let counter = countersStore.counterList.first(where: { $0.id == counter.id }) else { return }
            localStore.bindCounter(counter: counter)
        }
    }
    
    @ViewBuilder
    private func saveButton() -> some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(localStore.color)
            .modifier(ShadowModifier(foregroundColor: .black, cornerRadius: 20))
            .frame(width: 220, height: 48)
            .overlay {
                Text(Localized.shared.createCounter.saveButton)
                    .font(.myFont(type: .bold, size: 18))
                    .foregroundStyle(.textDark)
            }
            .onTapGesture {
                countersStore.saveCounter(newCounter: localStore.saveCounter())
                dismiss()
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
            Text(Localized.shared.createCounter.colorPicker)
                .font(.myFont(type: .regular, size: 14))
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


#Preview {
    ScreenBuilder.shared.getScreen(screenType: .editCounter(Counter(name: "Counter2", desc: "bla bla bla jsadk jjda kdjnak sjdkas ndkjasndk anskdj akjsdnaskj dnashb dhasdb jasdl asd;am lsdjk na", count: 123, lastRecord: Date(), colorHex: "04d4f4", isFavorite: true, targetCount: 500, dateCreate: Date())))
}
