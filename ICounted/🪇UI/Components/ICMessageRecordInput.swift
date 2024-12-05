//
//  ICMessageRecordInput.swift
//  ICounted
//
//  Created by Nebo on 05.12.2024.
//

import SwiftUI

struct ICMessageRecordInput: View {
    
    @Environment(\.countersStore) var countersStore: CountersStore
    var counter: Counter
    @State var message: String = "gggg"
    @FocusState var keyboardFocused: Bool
    
    var body: some View {
        
        HStack {
            ICTextField(text: $message, name: "Record Message", placeholder: "message", lineLimit: 2...6, maxLength: 500)
                .focused($keyboardFocused)
                .padding(.trailing, 12)
                .ignoresSafeArea(.keyboard, edges: .bottom)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        keyboardFocused = true
                    }
                }
            RoundedRectangle(cornerRadius: 16)
                .foregroundStyle(Color(hex: counter.colorHex))
                .frame(width: 80, height: 32)
                .overlay {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(style: .init(lineWidth: 2))
                        .foregroundStyle(.black)
                    Text("count")
                        .font(.system(size: 14))
                }
                .onTapGesture {
                    countersStore.countPlus(counter: counter, message: message)
                }.padding(.trailing, 8)
        }
    }
}

#Preview {
    ScreenBuilder.shared.getComponent(componentType: .messageRecordInput(Counter(name: "asdsd", desc: "asd", count: 123, lastRecord: Date(), colorHex: "FFFAAA", isFavorite: false, targetCount: nil)))
}
