//
//  ICNumberSetterView.swift
//  ICounted
//
//  Created by Nebo on 04.10.2024.
//

import SwiftUI

fileprivate enum NumberOperations {
    case plus(Int), minus(Int), multiply, divide
}

struct ICNumberSetterView: View {
    
    @Binding var number: Int
    
    var body: some View {
        HStack(spacing: 4) {
            let string = String(number).map { String($0) }
            newNumber()
            ForEach(0..<string.count, id: \.self) { i in
                VStack(spacing: 0, content: {
                    plusButton(position: i)
                    number(numb: string[i], color: .background1)
                    minusButton(position: i)
                })
            }
            delNumber()
        }
    }
    
    @ViewBuilder
    private func plusButton(position: Int) -> some View {
        Rectangle()
            .frame(width: 22, height: 14)
            .border(.black)
            .clipShape(
                .rect(topLeadingRadius: 2, bottomLeadingRadius: 0, bottomTrailingRadius: 0, topTrailingRadius: 2)
            )
            .foregroundStyle(.positive)
            .overlay {
                Image(systemName: "plus")
                    .resizable()
                    .foregroundStyle(.textDark)
                    .frame(width: 6, height: 6)
            }
            .onTapGesture {
                changedNumber(operation: .plus(position))
            }
    }
    
    @ViewBuilder
    private func minusButton(position: Int) -> some View {
        Rectangle()
            .frame(width: 22, height: 14)
            .border(.black)
            .clipShape(
                .rect(topLeadingRadius: 0, bottomLeadingRadius: 2, bottomTrailingRadius: 2, topTrailingRadius: 0)
                
            )
            .foregroundStyle(.negative)
            .overlay {
                Image(systemName: "minus")
                    .resizable()
                    .foregroundStyle(.textDark)
                    .frame(width: 6, height: 1)
            }
            .onTapGesture {
                changedNumber(operation: .minus(position))
            }
    }

    @ViewBuilder
    private func number(numb: String, color: Color, lineWidth: CGFloat = 1) -> some View {
        Text(numb)
            .font(.system(size: 16))
            .foregroundStyle(.textDark)
            .frame(width: 26, height: 34)
            .background(color)
            .cornerRadius(4)
            .overlay {
                RoundedRectangle(cornerRadius: 4)
                    .stroke(lineWidth: lineWidth)
                    .foregroundStyle(.textDark)
            }
    }
    
    
    private func changedNumber(operation: NumberOperations) {
        switch operation {
        case .plus(let position):
            var numbString = String(number).map { String($0) }
            numbString[position] =  numbString[position] != "9" ?  String(Int(numbString[position])! + 1) : "0"
            number = Int(numbString.joined())!
        case .minus(let position):
            var numbString = String(number).map { String($0) }
            numbString[position] =  numbString[position] != "0" ?  String(Int(numbString[position])! - 1) : "9"
            number = Int(numbString.joined())!
        case .multiply:
            if number == 0 {
                number = 10
            } else {
                number = number * 10
            }
        case .divide:
            number = number / 10
        }
    }
    
    @ViewBuilder
    private func newNumber() -> some View {
        number(numb: "", color: .gray.opacity(0.4), lineWidth: 0)
            .overlay {
                Image(systemName: "plus")
                    .resizable()
                    .foregroundStyle(.black)
                    .frame(width: 10, height: 10)
            }
            .foregroundColor(.red)
            .onTapGesture {
                changedNumber(operation: .multiply)
            }
    }
    
    @ViewBuilder
    private func delNumber() -> some View {
        number(numb: "", color: .gray.opacity(0.4), lineWidth: 0)
            .overlay {
                Image(systemName: "minus")
                    .resizable()
                    .foregroundStyle(.black)
                    .frame(width: 10, height: 1)
            }
            .onTapGesture {
                changedNumber(operation: .divide)
            }
    }
}
//
//#Preview {
//    CreateCounterScreen(isShow: .constant(true))
//}
