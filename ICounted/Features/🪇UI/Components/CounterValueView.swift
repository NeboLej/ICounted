//
//  CounterValueView.swift
//  ICounted
//
//  Created by Nebo on 07.07.2024.
//

import SwiftUI

struct CounterValueView: View {
    
    @Binding var count: Int
    let width: CGFloat
    let height: CGFloat
    let fontSize: CGFloat
    let cornerRadius: CGFloat
    
    init(count: Binding<Int>, width: CGFloat = 16, height: CGFloat = 24, fontSize: CGFloat = 16, cornerRadius: CGFloat = 2) {
        self._count = count
        self.width = width
        self.height = height
        self.fontSize = fontSize
        self.cornerRadius = cornerRadius
    }
    
    var body: some View {
        HStack(spacing: 3) {
            let string = String(count).map { String($0) }
            ForEach(0..<string.count, id: \.self) { i in
                Text(string[i])
                    .font(.system(size: fontSize))
                    .foregroundStyle(.textDark)
                    .frame(width: width, height: height)
                    .background(Color.background1)
                    .overlay {
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .stroke(lineWidth: 1)
                            .foregroundStyle(.textDark)
                    }
            }
        }
    }
}

#Preview {
    CounterValueView(count: .init(get: {
        return 231
    }, set: { _ in }))
}
