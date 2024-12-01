//
//  AlertView.swift
//  ICounted
//
//  Created by Nebo on 12.10.2024.
//

import SwiftUI

struct AlertView: View {
    
    let model: AlertModel
    
    @StateObject var store: Store<CounterListState, CounterListAction>
    @State private var isShow = false
    
    var body: some View {
        ZStack {
            ICBackBlurView().blur(radius: isShow ? 3 : 0)
            
            VStack(spacing: 0) {
                Rectangle()
                    .foregroundStyle(model.type.getColor())
                    .frame(height: 40)
                    .overlay {
                        Text((!model.title.isEmpty ? model.title : model.type.rawValue).uppercased())
                    }
                Rectangle()
                    .frame(height: 2)
                    .foregroundStyle(.black)
                
                model.type.getImage()
                    .padding(.top, 10)
                
                Text(model.message)
                    .font(.system(size: 14))
                    .foregroundStyle(.textInfo)
                    .padding(16)
                
                
                if model.actions.isEmpty {
                    getAction(action: .init(name: "OK", completion: {}))
                        .padding([.horizontal, .bottom], 16)
                        .padding(.bottom, 26)
                } else if model.actions.count > 2 {
                    VStack(spacing: 10) {
                        getActions()
                    }.padding([.horizontal, .bottom], 16)
                        .padding(.bottom, 26)
                } else {
                    HStack(spacing: 14) {
                        getActions()
                    }.padding(.horizontal, 16)
                        .padding(.bottom, 26)
                }
            }
            
            .background(.background1)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .overlay {
                RoundedRectangle(cornerRadius: 15)
                    .stroke(.black, lineWidth: 1)
            }
            .padding(.horizontal, 16)
            .offset(y: isShow ? 0 : 600)
            .scaleEffect(CGSize(width: isShow ? 1.0 : 0.01, height: 1.0))
        }.ignoresSafeArea()
            .animation(.smooth(duration: 0.3), value: isShow)
            .onAppear(perform: {
                isShow = true
            })
    }
    
    @ViewBuilder
    private func getActions() -> some View {
        ForEach(model.actions) {
            getAction(action: $0)
        }
    }
    
    @ViewBuilder
    private func getAction(action: AlertAction) -> some View {
        Rectangle()
            .fill(model.type.getColor())
            .modifier(ShadowModifier(foregroundColor: .background1, cornerRadius: 17))
            .frame(width: 150, height: 34)
            .overlay {
                Text(action.name)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(.textDark)
            }
            .onTapGesture {
                withAnimation {
                    isShow = false
                } completion: {
                    action.completion()
                    store.dispatch(.dismissAlert)
                }
            }
    }
}

//#Preview {
//    AlertView(model: .init(type: .warning, title: "WTF???", message: "ksdka aksdl m?", actions: [.init(name: "first", completion: {}), .init(name: "second", completion: {})]))
//}
