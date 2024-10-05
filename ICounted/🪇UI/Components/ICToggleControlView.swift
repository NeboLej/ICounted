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
            isOn.toggle()
        }
        
    }
    
}

#Preview {
    CreateCounterScreen(isShow: .constant(true))
}
