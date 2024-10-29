//
//  ICTextField.swift
//  ICounted
//
//  Created by Nebo on 03.10.2024.
//

import SwiftUI

struct ICTextField: View {
    
    @Binding private var text: String
    private let name: String
    private let maxLength: Int
    private let lineLimit: ClosedRange<Int>
    private let placeholder: String
    private let isEnabled: Bool
    
    @State private var progress: Double = 0
    
    init(text: Binding<String>, name: String = "", placeholder: String = "",
         lineLimit: ClosedRange<Int> = 1...1, maxLength: Int = 100, isEnabled: Bool = true) {
        self.name = name
        self.maxLength = maxLength
        self.lineLimit = lineLimit
        self.placeholder = placeholder
        self.isEnabled = isEnabled
        self._text = text
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(name)
                    .font(.system(size: 14))
                    .foregroundStyle(.textInfo)
                    .padding(.horizontal, 12)
                Spacer()
            }
            textField()
        }
    }
    
    @ViewBuilder
    private func textField() -> some View {
        ZStack(alignment: .top) {
            TextField("", text: $text, prompt: Text(placeholder).foregroundStyle(.textInfo.opacity(0.5)), axis: .vertical)
                .lineLimit(lineLimit)
                .padding(EdgeInsets(top: 12, leading: 12, bottom: 10, trailing: 12))
                .background(.white)
                .tint(.blue)
                .foregroundStyle(.black)
                .disabled(!isEnabled)
                .onChange(of: text, { oldValue, newValue in
                    if newValue.count > maxLength {
                        text = oldValue
                    } else {
                        calculateProgress(text: newValue)
                    }
                })
                .onAppear { calculateProgress(text: text) }
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 3.0)
                        .foregroundStyle(.black)
                )
                .cornerRadius(10)
                .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/, radius: 0, x: 3, y: 4)
                .padding(.top, 2)
            
            ICTextProgressBar(progress: $progress)
                .frame(height: 5)
                .padding(.horizontal, 12)
        }
    }
    
    private func calculateProgress(text: String) {
        progress = (100 / Double(maxLength)) * Double(text.count)
    }
}

//
//#Preview {
//    CreateCounterScreen(isShow: .constant(true))
//}
