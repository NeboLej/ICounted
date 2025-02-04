//
//  CountersListScreen.swift
//  ICounted
//
//  Created by Nebo on 07.07.2024.
//

import SwiftUI

struct CountersListScreen: View {
    
    @State var isShowCreateCounter = false
    @State var selectedCounter: Counter? = nil
    @State var longPressCounter: Counter? = nil
    @State var isShowMessageInput = false
    
    @Environment(\.countersStore) var countersStore: CountersStore
    @Environment(\.screenBuilder) var screenBuilder: ScreenBuilder
    
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
                Spacer(minLength: 68)
            }.background(Color.background1)
            
            createCounterButton()
                .padding(.trailing, 16)
        }
        .overlay {
            if isShowMessageInput, longPressCounter != nil {
                screenBuilder.getComponent(componentType: .messageRecordInput(longPressCounter!, $isShowMessageInput.animation()))
            }
        }
        .overlay {
            if countersStore.counterList.isEmpty {
                EmptyStateView {
                    isShowCreateCounter = true
                }
            }
        }
        .onAppear {
            
        }
        .sheet(isPresented: $isShowCreateCounter) {
            screenBuilder.getScreen(screenType: .createCounter)
        }
        .sheet(isPresented: .init(get: { selectedCounter != nil }, set: { _ in selectedCounter = nil }) , onDismiss: {
            selectedCounter = nil
        }, content: {
            screenBuilder.getScreen(screenType: .counter(selectedCounter!))
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
            .frame(width: 54, height: 54)
            .onTapGesture {
                isShowCreateCounter = true
            }
    }
    
    @ViewBuilder
    private func counterList() -> some View {
        ForEach(countersStore.counterList) { counter in
            screenBuilder.getComponent(componentType: .counterCell(counter))
                .modifier(TapAndLongPressModifier(isVibration: false, tapAction: {
                    Vibration.light.vibrate()
                    selectedCounter = counter
                }, longPressAction: {
                    longPressCounter = counter
                    isShowMessageInput = true
                }))
        }
    }
    
    @ViewBuilder
    private func emptyStateView() -> some View {
        EmptyStateView {
            isShowCreateCounter = true
        }
    }
    
    @ViewBuilder
    private func counter() -> some View {
        VStack {
            Text(Localized.CounterListScreen.counterPanel)
                .font(.myFont(type: .regular, size: 16))
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
            Text(Localized.CounterListScreen.countPanel)
                .font(.myFont(type: .regular, size: 16))
                .foregroundStyle(.textDark)
            Text(Localized.CounterListScreen.countPanelDesc)
                .font(.myFont(type: .regular, size: 8))
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
            Text(Localized.CounterListScreen.settingPanel)
                .font(.myFont(type: .regular, size: 16))
                .foregroundStyle(.textDark)
        }
    }
    
}

#Preview {
    ScreenBuilder.shared.getScreen(screenType: .counterList)
}
