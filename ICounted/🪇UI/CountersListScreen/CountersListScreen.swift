//
//  CountersListScreen.swift
//  ICounted
//
//  Created by Nebo on 07.07.2024.
//

import SwiftUI

struct CountersListScreen: View {
    
    @State private var isShowCreateCounter = false
    @State private var selectedCounter: Counter? = nil
    @State private var longPressCounter: Counter? = nil
    @State private var isShowMessageInput = false
    @State private var isShowSetting = false
    @State private var localStore = CounterListScreenStore()
    
    @Environment(\.countersStore) var countersStore: CountersStore
    @Environment(\.screenBuilder) var screenBuilder: ScreenBuilder
    @Environment(\.settingsStore) var settingsStore: SettingStore
    
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
                    .overlay {
                        tooltipView()
                    }
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
        .onChange(of: countersStore.counterList, { oldValue, newValue in
            localStore.bindCounterList(counters: countersStore.counterList)
        })
        .sheet(isPresented: $isShowCreateCounter) {
            screenBuilder.getScreen(screenType: .createCounter)
        }
        .sheet(isPresented: $isShowSetting, onDismiss: {
            settingsStore.isReturnToSettings = false
        }, content: {
            screenBuilder.getScreen(screenType: .settings)
        })
        .sheet(isPresented: .init(get: { selectedCounter != nil }, set: { _ in selectedCounter = nil }) , onDismiss: {
            selectedCounter = nil
        }, content: {
            screenBuilder.getScreen(screenType: .counter(selectedCounter!))
        })
        .onAppear {
            isShowSetting = settingsStore.isReturnToSettings
        }
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
                .onTapGesture {
                    isShowSetting = true
                }
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
                    localStore.didUserSawTooltip()
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
    private func tooltipView() -> some View {
        ICTooltipView( alignment: .bottom, isVisible: $localStore.isShowTooltip) {
            VStack{
                Text(Localized.shared.counterListScreen.tooltipLongpress)
                    .font(.myFont(type: .regular, size: 18))
                    .lineSpacing(4)
                    .frame(width: 200)
                    .padding(.bottom, 4)
                
                RoundedRectangle(cornerRadius: 20)
                    .fill(.background3)
                    .modifier(ShadowModifier(foregroundColor: .black, cornerRadius: 20))
                    .frame(width: 100, height: 30)
                    .overlay {
                        Text(Localized.shared.component.tooltipOkButton)
                            .font(.myFont(type: .bold, size: 18))
                            .foregroundStyle(.textDark)
                            .padding(.horizontal, 5)
                            .padding(.top, 5)
                    }.onTapGesture {
                        localStore.didUserSawTooltip()
                    }
            }
        }
    }
    
    @ViewBuilder
    private func counter() -> some View {
        VStack {
            Text(Localized.shared.counterListScreen.counterPanel)
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
            Text(Localized.shared.counterListScreen.countPanel)
                .font(.myFont(type: .regular, size: 16))
                .foregroundStyle(.textDark)
            Text(Localized.shared.counterListScreen.countPanelDesc)
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
            Text(Localized.shared.counterListScreen.settingPanel)
                .font(.myFont(type: .regular, size: 16))
                .foregroundStyle(.textDark)
        }
    }
    
}

#Preview {
    ScreenBuilder.shared.getScreen(screenType: .counterList)
}
