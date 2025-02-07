//
//  ICMessageRecordInput.swift
//  ICounted
//
//  Created by Nebo on 05.12.2024.
//

import SwiftUI

struct ICMessageRecordInput: View {
    
    @Environment(\.countersStore) var countersStore: CountersStore
    var counter: Counter
    @State var selectDate = Date()
    
    @State private var message: String = ""
    @FocusState private var keyboardFocused: Bool
    @Binding var isShow: Bool
    
    var body: some View {
        ZStack {
            BackdropBlurView(radius: 6)
                .ignoresSafeArea()
                .onTapGesture {
                    Vibration.light.vibrate()
                    keyboardFocused = false
                    isShow = false
                }
            VStack(spacing: 0) {
                Spacer()
                VStack {
                    DatePicker(selection: $selectDate) {
                        Text(Localized.shared.component.messageFormDate)
                            .font(.myFont(type: .regular, size: 14))
                            .foregroundStyle(.textInfo)
                            .padding(.horizontal, 12)
                    }.padding(.horizontal, 12)
                    HStack {
                        ICTextField(text: $message, name: Localized.shared.component.messageFormMessageTF, placeholder: Localized.shared.component.messageFormMessageTFPlaceholder, lineLimit: 2...6, maxLength: 500)
                            .focused($keyboardFocused)
                            .padding(.horizontal, 12)
                            .padding(.bottom, 6)
                            .ignoresSafeArea(.keyboard, edges: .bottom)
                        
                        RoundedRectangle(cornerRadius: 16)
                            .foregroundStyle(Color(hex: counter.colorHex))
                            .frame(width: 80, height: 32)
                            .overlay {
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(style: .init(lineWidth: 2))
                                    .foregroundStyle(.black)
                                Text(Localized.shared.component.messageFormAddCountButton)
                                    .font(.myFont(type: .regular, size: 14))
                            }
                            .onTapGesture {
                                keyboardFocused = false
                                countersStore.countPlus(counter: counter, message: message, date: selectDate)
                                isShow = false
                            }.padding(.trailing, 8)
                    }
                }
                .padding(.vertical, 12)
                
                .background(Color(hex: counter.colorHex).opacity(0.8))
                .clipShape(
                    UnevenRoundedRectangle(cornerRadii: .init(topLeading: 20, bottomLeading: 0, bottomTrailing: 0, topTrailing: 20), style: .continuous)
                )
                .overlay(
                    UnevenRoundedRectangle(cornerRadii: .init(topLeading: 20, bottomLeading: 0, bottomTrailing: 0, topTrailing: 20), style: .continuous)
                        .stroke(.black, lineWidth: 2)
                )
            }
        }
        .ignoresSafeArea(.container)
        .onAppear {
            Vibration.medium.vibrate()
            keyboardFocused = true
        }
    }
}

#Preview {
    ScreenBuilder.shared.getComponent(componentType: .messageRecordInput(Counter(name: "asdsd", desc: "asd", count: 123, lastRecord: Date(), colorHex: "FFFAAA", isFavorite: false, targetCount: nil), .constant(true)))
}


//#Preview {
//    ScreenBuilder.shared.getScreen(screenType: .counterList)
//}


struct BackdropView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView()
        let blur = UIBlurEffect()
        let animator = UIViewPropertyAnimator()
        animator.addAnimations { view.effect = blur }
        animator.fractionComplete = 0
        animator.stopAnimation(false)
        animator.finishAnimation(at: .current)
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) { }
    
}

struct BackdropBlurView: View {
    
    let radius: CGFloat
    
    @ViewBuilder
    var body: some View {
        BackdropView().blur(radius: radius)
    }
}
