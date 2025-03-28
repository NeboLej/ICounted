//
//  ICTagCloudView.swift
//  ICounted
//
//  Created by Nebo on 24.01.2025.
//

import SwiftUI

@MainActor
struct EmptyStateView: View {
    
    var startCreate: () ->()
    @State private var scaleX: CGFloat = 1
    @State private var scaleY: CGFloat = 1
    @State private var offsetX: CGFloat = 0
    @State private var offsetY: CGFloat = 0
    @State private var degreesZ: CGFloat = 1
    
    var body: some View {
        ZStack {
            Image(.emptyStateBackground)
                .resizable()
                .opacity(0.4)
                .scaleEffect(x: scaleX, y: scaleY)
                .offset(x: offsetX, y: offsetY)
                .rotation3DEffect(.degrees(degreesZ), axis: (x: 0, y: 0, z: 20))
                .ignoresSafeArea()
                .onAppear {
                    withAnimation(Animation.easeInOut(duration: 10).repeatForever(autoreverses: true)) {
                        scaleX = 1.5
                        scaleY = 1.1
                        offsetX = 100
                        offsetY = 40
                        degreesZ = 10
                    }
                }
            
            VStack {
                ICTagCloudView(words: Localized.shared.component.welcomePageTagsArray.split(separator: "@").map { String($0) })
                
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .clipped()
                
                Spacer()
            }.ignoresSafeArea()
            
            VStack {
                Text(Localized.shared.component.welcomePageDescription)
                    .font(.myFont(type: .bold, size: 20))
                    .foregroundColor(.textDark)
                    .frame(maxWidth: .infinity)
                    .padding(20)
            }.background(.white)
            
            HStack {
                Spacer()
                VStack(spacing: 0) {
                    Spacer()
                    createCounterButton()
                    
                    Text(Localized.shared.component.welcomePageAddCounterButton)
                        .font(.myFont(type: .bold, size: 18))
                        .foregroundColor(.textDark)
                        .padding(.top, 10)
                    
                }.padding(.trailing, 20)
            }
            
        }
        .background(.background1)
    }
    
    @ViewBuilder
    private func createCounterButton() -> some View {
        Image(systemName: "plus.circle.fill")
            .resizable()
            .foregroundStyle(.background3)
            .modifier(ShadowModifier(foregroundColor: .black, cornerRadius: 30))
            .frame(width: 60, height: 60)
            .onTapGesture {
                startCreate()
            }
    }
}



struct ICTagCloudView: View {
    @State var words: [String] = []
    
    var body: some View {
        ZStack {
            ForEach(words, id: \.self) { word in
                AnimationTagView(word: word)
            }
        }
    }
}

struct AnimationTagView: View {
    
    @State var word: String
    @State var startOffsetX: CGFloat = 0
    @State var startOffsetY: CGFloat = 100
    @State var opacity: CGFloat = 1
    @State var duration: CGFloat = CGFloat.random(in: 10...20)
    @State var color: Color!
    @State var rotationEffectAngle: CGFloat = 5
    @State var delay: CGFloat = CGFloat.random(in: 0...2)
    @State var colors: [Color] = ["#FDDD03", "#95D385", "#53A4F0", "#F58F8F", "D385BD", "58D4AF", "D45858"].map { Color(hex: $0) }
    
    var body: some View {
        tagView(word: word)
            .offset(x: startOffsetX, y: startOffsetY)
            .opacity(opacity)
            .onChange(of: startOffsetX) { oldValue, newValue in
                animate2()
            }
            .rotationEffect(.degrees(rotationEffectAngle))
            .onAppear {
                startOffsetX = -1
            }
    }
    
    func animate2() {
        startOffsetX = CGFloat.random(in: -150...150)
        color = colors.randomElement()!
        startOffsetY = -50
        opacity = 1
        
        withAnimation(Animation.easeInOut(duration: duration).delay(delay)) {
            startOffsetY = CGFloat.random(in: 400...500)
            opacity = 0
            color = colors.randomElement()!
            
            withAnimation(Animation.easeInOut(duration: CGFloat.random(in: 2...4)).delay(0).repeatForever(autoreverses: true)) {
                rotationEffectAngle = -5
            }
            
        } completion: {
            startOffsetX = CGFloat.random(in: -150...150)
            delay = CGFloat.random(in: 0...5)
        }
    }
    
    //    func animate() {
    //        withAnimation(Animation.easeInOut(duration: duration).delay(delay)) {
    //            startOffsetX = -startOffsetX
    //            startOffsetY = -startOffsetY
    //            opacity = 1
    //            color = colors.randomElement()!
    //        } completion: {
    //            withAnimation(Animation.easeInOut(duration: 1)) {
    //                opacity = 0
    //            } completion: {
    //                color = colors.randomElement()!
    //                startOffsetX = CGFloat.random(in: -150...150)
    //                startOffsetY = CGFloat.random(in: -300...300)
    ////                animate()
    //            }
    //        }
    //    }
    
    @ViewBuilder func tagView(word: String) -> some View {
        ZStack {
            Text(word)
                .font(.myFont(type: .regular, size: 14))
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
        }
        .background(colors.randomElement()!)
        .cornerRadius(16)
        .overlay{
            RoundedRectangle(cornerRadius: 16)
                .stroke(.black, lineWidth: 2)
        }
    }
}


#Preview {
    EmptyStateView(startCreate: {})
}
