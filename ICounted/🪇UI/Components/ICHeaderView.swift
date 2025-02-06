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
                .font(.myFont(type: .semiBold, size: 18))
                .padding(.bottom, 12)
                .padding(.top, 16)
            Rectangle()
                .fill(.black)
                .frame(height: 1)
        }
        .background(color)
    }
}

#Preview {
    ICHeaderView(name: "asd afr", color: .background2)
}
