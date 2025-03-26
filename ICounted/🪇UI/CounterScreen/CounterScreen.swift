//
//  CounterScreen.swift
//  ICounted
//
//  Created by Nebo on 06.10.2024.
//

import SwiftUI

struct CounterScreen: View {
    
    @Environment(\.countersStore) var countersStore: CountersStore
    @Environment(\.screenBuilder) var screenBuilder: ScreenBuilder
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    
    @State var counter: Counter
    
    @State private var localStore = CounterScreenStore()
    @State private var isShowMessageInput: Bool = false
    @State private var isShowMenu: Bool = false
    @State private var isShowEditCounter = false
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        VStack {
            ICHeaderView(name: localStore.name, color: localStore.color)
            
            ScrollView(.vertical) {
                VStack(spacing: 16) {
                    isFavoriteView()
                    descriptionView()
                    counterProgressView()
                    ICCalendarChart(recordsDate: $localStore.recordsDate, selectedDate: $localStore.selectedDate, color: $localStore.color)
                        .padding(.top, 16)
                    selectedDateRecords()
                }.padding(.horizontal, 16)
            }
            
            HStack(alignment: .center) {
                menu()
                Spacer()
                countButton()
                    .overlay {
                        tooltipView()
                            .offset(x: -16)
                    }
            }
            .padding(.horizontal, 16)
            
        }
        .padding(.bottom, UIDevice.current.userInterfaceIdiom == .pad ? 16 : 0)
        .background(.background1)
        .overlay {
            if isShowMessageInput {
                screenBuilder.getComponent(componentType: .messageRecordInput(counter, $isShowMessageInput.animation()))
            }
        }
        .onAppear {
            localStore.bindCounter(counter: counter)
        }
        .sheet(isPresented: $isShowEditCounter) {
            screenBuilder.getScreen(screenType: .editCounter(counter))
        }
        .onChange(of: countersStore.allCount) {
            guard let counter = countersStore.counterList.first(where: { $0.id == counter.id }) else { return }
            localStore.bindCounter(counter: counter)
        }
        .onChange(of: isShowEditCounter) {
            guard let counter = countersStore.counterList.first(where: { $0.id == counter.id }) else { return }
            localStore.bindCounter(counter: counter)
        }
        .modifier(AlertModifier(alert: localStore.alert))
    }
    
    @ViewBuilder
    private func isFavoriteView() -> some View  {
        HStack {
            Spacer()
            Text(Localized.shared.counter.toWidget)
                .font(.myFont(type: .regular, size: 14))
                .foregroundStyle(.textInfo)
            Image(localStore.isAddToWidget ? .starActive : .star)
        }
    }
    
    @ViewBuilder
    private func descriptionView() -> some View {
        HStack {
            if !localStore.description.isEmpty {
                Text(localStore.description)
                    .font(.myFont(type: .medium, size: 16))
                    .lineSpacing(4)
                    .foregroundStyle(colorScheme == .light ? .textDark : .textLight)
            }
            Spacer()
        }
    }
    
    @ViewBuilder
    private func counterProgressView() -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text(Localized.shared.counter.currentValue)
                    .font(.myFont(type: .regular, size: 14))
                    .foregroundStyle(.textInfo)
                CounterValueView(count: localStore.count, width: 20, height: 30)
            }
            
            Spacer()
            
            if localStore.isUseTargetValue {
                VStack(alignment: .trailing) {
                    Text(Localized.shared.counter.targetValue)
                        .font(.myFont(type: .regular, size: 14))
                        .foregroundStyle(.textInfo)
                    CounterValueView(count: localStore.targetCount, width: 20, height: 30)
                }
            }
        }.padding(.top, 16)
        
        if localStore.isUseTargetValue {
            progressBar()
                .padding(.top, 16)
        }
    }
    
    @ViewBuilder
    private func selectedDateRecords() -> some View {
        VStack {
            HStack {
                Text(localStore.selectedDate?.toReadableDate() ?? "")
                    .font(.myFont(type: .regular, size: 16))
                    .foregroundStyle(colorScheme == .light ? .textDark : .textLight)
                Spacer()
                Text(localStore.selectedDate != nil ? Localized.shared.counter.recordsCount(localStore.selectedRecords.count) : "")
                    .font(.myFont(type: .regular, size: 14))
                    .foregroundStyle(.textInfo)
            }
            .padding(.top, 16)
            .padding(.bottom, 4)
            ForEach(localStore.selectedRecords) { record in
                RecordCell(record: record, color: localStore.color) { onDeleteRecord in
                    localStore.showAlertDeleteRecord {
                        countersStore.deleteRecord(record: onDeleteRecord, counter: counter)
                        localStore.alert = nil
                    } negativeAction: {
                        localStore.alert = nil
                    }
                }
            }
        }
        .padding(.bottom, 8)
    }
    
    @ViewBuilder
    private func countButton() -> some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(localStore.color)
            .modifier(ShadowModifier(foregroundColor: .black, cornerRadius: 20))
            .frame(width: 180, height: 40)
            .overlay {
                Text(Localized.shared.counter.addCountButton)
                    .font(.myFont(type: .bold, size: 18))
                    .foregroundStyle(.textDark)
            }
            .modifier(TapAndLongPressModifier(isVibration: true, tapAction: {
            countersStore.countPlus(counter: counter)
        }, longPressAction: {
            isShowMessageInput = true
            localStore.didUserSawTooltip()
        }))
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
                Text(Localized.shared.counter.menuEdit)
                    .font(.myFont(type: .regular, size: 14))
                    .padding(.bottom, 6)
                    .foregroundStyle(colorScheme == .light ? .textDark : .textLight)
                    .onTapGesture {
                        isShowEditCounter = true
                    }
                Text(Localized.shared.counter.menuDelete)
                    .font(.myFont(type: .regular, size: 14))
                    .foregroundStyle(colorScheme == .light ? .textDark : .textLight)
                    .onTapGesture {
                        localStore.showAlertDeleteCounter {
                            countersStore.deleteCounter(counter: counter)
                            dismiss()
                        } negativeAction: {
                            localStore.alert = nil
                        }
                    }
            }.opacity(isShowMenu ? 1 : 0)
        }
        .animation(.easeOut(duration: 0.3), value: isShowMenu)
    }
    
    @ViewBuilder
    private func progressBar() -> some View {
        VStack(alignment: .trailing) {
            Text(String(format: "%.1f", localStore.progress)+"%")
                .font(.myFont(type: .regular, size: 14))
                .foregroundStyle(.textInfo)
            ICTextProgressBar(progress: .constant(localStore.progress), color: $localStore.color)
                .frame(height: 10)
        }
    }
    
    @ViewBuilder
    private func tooltipView() -> some View {
        ICTooltipView( alignment: .top, isVisible: $localStore.isShowTooltip) {
            VStack{
                Text(Localized.shared.counter.tooltipLongpress)
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
}

#Preview {
    ScreenBuilder.shared.getScreen(screenType: .counter(Counter(name: "Counter", desc: "bla bla bla jsadk jjda kdjnak sjdkas ndkjasndk anskdj akjsdnaskj dnashb dhasdb jasdl asd;am lsdjk na", count: 133, lastRecord: Date(), colorHex: "04d4f4", isFavorite: true, targetCount: 500, dateCreate: Date())))
}
