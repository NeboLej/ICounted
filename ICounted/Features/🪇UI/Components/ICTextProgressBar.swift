//
//  ICTextProgressBar.swift
//  ICounted
//
//  Created by Nebo on 04.10.2024.
//

import SwiftUI

struct ICTextProgressBar: View {
    
    @Binding var progress: Double
    
    var body: some View {
        GeometryReader { metrics in
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(.background1)
                    .border(.black)
                Rectangle()
                    .fill(.red)
                    .frame(width: metrics.size.width * progress / 100)
                    .border(.black)
            }
        }
    }
}

#Preview {
    ICTextProgressBar(progress: .init(get: { return 33 }, set: { _ in }))
}
