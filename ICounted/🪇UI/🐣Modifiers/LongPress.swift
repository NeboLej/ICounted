//
//  LongPress.swift
//  ICounted
//
//  Created by Nebo on 04.02.2025.
//

import SwiftUI

struct TapAndLongPressModifier: ViewModifier {
    @State private var isLongPressing = false
    @State var isVibration: Bool
    let tapAction: (()->())
    let longPressAction: (()->())
    func body(content: Content) -> some View {
        content
            .scaleEffect(isLongPressing ? 0.95 : 1.0)
            .onTapGesture {
                tapAction()
            }
            .onLongPressGesture(minimumDuration: 0.2, maximumDistance: 2,
            perform: {
                longPressAction()
            },
            onPressingChanged: { isPressing in
                if isVibration {
                    Vibration.light.vibrate()
                }
                withAnimation {
                    isLongPressing = isPressing
                }
                
            })
    }
}
