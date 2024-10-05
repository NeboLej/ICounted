//
//  ShadowModifier.swift
//  ICounted
//
//  Created by Nebo on 07.07.2024.
//

import SwiftUI

struct ShadowModifier: ViewModifier {
    
    let foregroundColor: UIColor
    let shadowColor: UIColor
    let cornerRadius: CGFloat
    let borderColor: UIColor
    let lineWidth: CGFloat
    let xOffset: CGFloat
    let yOffser: CGFloat
    
    init(foregroundColor: UIColor = .red, shadowColor: UIColor = .black, cornerRadius: CGFloat = 10, borderColor: UIColor = .black, lineWidth: CGFloat = 2, xOffset: CGFloat = 3, yOffser: CGFloat = 4) {
        self.foregroundColor = foregroundColor
        self.shadowColor = shadowColor
        self.cornerRadius = cornerRadius
        self.borderColor = borderColor
        self.lineWidth = lineWidth
        self.xOffset = xOffset
        self.yOffser = yOffser
    }
    
    func body(content: Content) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius)
                .shadow(color: Color(shadowColor), radius: 0, x: xOffset, y: yOffser)
                .foregroundStyle(Color(foregroundColor))
            
            content.cornerRadius(cornerRadius)
            
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(Color(borderColor), lineWidth: lineWidth)
        }
    }
}


#Preview {
    CountersListScreen()
        .environmentObject(TEST)
}
