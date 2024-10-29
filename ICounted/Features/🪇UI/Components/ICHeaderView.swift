//
//  ICHeaderView.swift
//  ICounted
//
//  Created by Nebo on 03.10.2024.
//

import SwiftUI

struct ICHeaderView: View {
    
    let name: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 0) {
            Text(name.uppercased())
                .foregroundStyle(.textDark)
                .font(.system(size: 18))
                .fontWeight(.semibold)
                .padding(.vertical, 16)
            Rectangle()
                .fill(.black)
                .frame(height: 1)
        }
        .background(color)
    }
}

#Preview {
    ICHeaderView(name: "asd", color: .background2)
}
