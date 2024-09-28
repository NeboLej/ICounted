//
//  CounterValueView.swift
//  ICounted
//
//  Created by Nebo on 07.07.2024.
//

import SwiftUI

struct CounterValueView: View {
    
    @Binding var count: Int
    
    var body: some View {
        HStack(spacing: 3) {
            let string = String(count).map { String($0) }
            ForEach(0..<string.count) { i in
                Text(string[i])
                    .font(.system(size: 16))
                    .foregroundStyle(.textDark)
                    .frame(width: 16, height: 24)
                    .background(Color.background1)
                    .overlay {
                        RoundedRectangle(cornerRadius: 2)
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
