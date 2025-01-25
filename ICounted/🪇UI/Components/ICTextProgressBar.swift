//
//  ICTextProgressBar.swift
//  ICounted
//
//  Created by Nebo on 04.10.2024.
//

import SwiftUI

struct ICTextProgressBar: View {
    
    @Binding var progress: Double
    @State var color: Color
    
    var body: some View {
        GeometryReader { metrics in
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(.background1)
                    .border(.black)
                Rectangle()
                    .fill(color)
                    .frame(width: getWidthByProgress(maxWidth: metrics.size.width))
                    .border(.black)
            }
        }
    }
    
    func getWidthByProgress(maxWidth: CGFloat) -> CGFloat {
        progress > 100 ? maxWidth : maxWidth * progress / 100
    }
}

#Preview {
    ICTextProgressBar(progress: .init(get: { return 33 }, set: { _ in }), color: .red)
}
