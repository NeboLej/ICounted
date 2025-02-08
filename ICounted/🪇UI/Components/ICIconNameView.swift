//
//  IconNameView.swift
//  ICounted
//
//  Created by Nebo on 28.09.2024.
//

import SwiftUI

struct ICIconNameView: View {
    
    let name: String
    let color: Color
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(color)
            
            Text(getAbbreviation(maxCount: 3))
                .foregroundStyle(.textDark)
                .font(.myFont(type: .bold, size: 16))
                .rotationEffect(.degrees(-45))
                .offset(x: 2, y: 2) //Font fix
            RoundedRectangle(cornerRadius: 15)
                .stroke(lineWidth: 2)
                .foregroundStyle(.black)
        }.clipShape(RoundedRectangle(cornerRadius: 15))
    }
    
    
    private func getAbbreviation(maxCount: Int) -> String {
        var words = name.split(separator: " ")
        var abbreviation = ""
        words = Array(words.prefix(maxCount))
        words.forEach { substring in
            if let char = substring.first {
                abbreviation += String(char)
            }
        }
        
        return abbreviation.uppercased()
    }
}

#Preview {
    ICIconNameView(name: "asd ds asd ff", color: .red)
        .frame(width: 50, height: 50)
}
