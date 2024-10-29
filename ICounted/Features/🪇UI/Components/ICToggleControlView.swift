//
//  ICToggleControlView.swift
//  ICounted
//
//  Created by Nebo on 05.10.2024.
//

import SwiftUI

struct ICToggleControlView: View {
    
    @Binding var isOn: Bool
    let color: Color
    let isEnabled: Bool
    
    init(isOn: Binding<Bool>, color: Color, isEnabled: Bool = true) {
        self._isOn = isOn
        self.color = color
        self.isEnabled = isEnabled
    }
    
    var body: some View {
        ZStack(alignment: isOn ? .trailing : .leading) {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 56, height: 32)
                .foregroundStyle(isOn ? color.opacity(0.5) : .toggleUnActive)
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.black)
                }
            
            Circle()
                .frame(width: 32, height: 32)
                .foregroundStyle(color)
                .overlay {
                    Circle()
                        .stroke(.black)
                }
        }
        .animation(.easeInOut(duration: 0.3), value: isOn)
        .onTapGesture {
            if isEnabled {
                isOn.toggle()
            }
        }
        
    }
    
}

//#Preview {
//    CreateCounterScreen(isShow: .constant(true))
//}
