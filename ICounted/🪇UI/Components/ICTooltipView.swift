//
//  ICTooltipView.swift
//  ICounted
//
//  Created by Nebo on 06.02.2025.
//

import SwiftUI

struct ICTooltipView<Content: View>: View {
    let alignment: Edge
    @Binding var isVisible: Bool
    let content: () -> Content
    let arrowOffset = CGFloat(8)

    private var oppositeAlignment: Alignment {
        let result: Alignment
        switch alignment {
        case .top: result = .bottom
        case .bottom: result = .top
        case .leading: result = .trailing
        case .trailing: result = .leading
        }
        return result
    }

    private var theHint: some View {
        content()
            .padding(.all, 16)
            .background(.tooltipBackground)
            .foregroundColor(.textLight)
            .cornerRadius(8)
            .background(alignment: oppositeAlignment) {
                Rectangle()
                    .fill(.tooltipBackground)
                    .frame(width: 22, height: 22)
                    .rotationEffect(.degrees(45))
                    .offset(x: alignment == .leading ? arrowOffset : 0)
                    .offset(x: alignment == .trailing ? -arrowOffset : 0)
                    .offset(y: alignment == .top ? arrowOffset : 0)
                    .offset(y: alignment == .bottom ? -arrowOffset : 0)
            }
            .padding()
            .fixedSize()
    }

    var body: some View {
        if isVisible {
            GeometryReader { proxy1 in
                theHint
                    .hidden()
                    .overlay {
                        GeometryReader { proxy2 in
                            theHint
                                .drawingGroup()
                                .shadow(radius: 4)
                                .offset(
                                    x: -(proxy2.size.width / 2) + (proxy1.size.width / 2),
                                    y: -(proxy2.size.height / 2) + (proxy1.size.height / 2)
                                )
                                .offset(x: alignment == .leading ? (-proxy2.size.width / 2) - (proxy1.size.width / 2) : 0)
                                .offset(x: alignment == .trailing ? (proxy2.size.width / 2) + (proxy1.size.width / 2) : 0)
                                .offset(y: alignment == .top ? (-proxy2.size.height / 2) - (proxy1.size.height / 2) : 0)
                                .offset(y: alignment == .bottom ? (proxy2.size.height / 2) + (proxy1.size.height / 2) : 0)
                        }
                    }
            }
        }
    }
}
//
//#Preview {
//    Rectangle()
//        .fill(Color.red)
//        .frame(width: 100, height: 100)
//        .overlay {
//            ICTooltipView(alignment: .bottom, isVisible: .constant(true)) {
//                VStack {
//                    Text("Hint")
//                    Image(systemName: "info.circle")
//                }
//                
//            }
//        }
//
//}


#Preview {
    ScreenBuilder.shared.getScreen(screenType: .counter(Counter(name: "Counter", desc: "bla bla bla jsadk jjda kdjnak sjdkas ndkjasndk anskdj akjsdnaskj dnashb dhasdb jasdl asd;am lsdjk na", count: 133, lastRecord: Date(), colorHex: "04d4f4", isFavorite: true, targetCount: 500)))
}
