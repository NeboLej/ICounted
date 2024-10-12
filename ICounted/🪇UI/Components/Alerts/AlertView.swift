//
//  AlertView.swift
//  ICounted
//
//  Created by Nebo on 12.10.2024.
//

import SwiftUI

enum AlertType: String {
    case success = "Success", error = "Error", warning = "Warning"
    
    func getColor() -> Color {
        switch self {
        case .success:
            Color.alertSuccess
        case .error:
            Color.alertError
        case .warning:
            Color.alertWarning
        }
    }
    
    func getImage() -> Image {
        switch self {
        case .success:
            Image(.alertSuccess)
        case .error:
            Image(.alertError)
        case .warning:
            Image(.alertWarning)
        }
    }
}

struct AlertAction: Identifiable {
    let id: UUID = UUID()
    let name: String
    let completion: () -> Void
}

struct AlertModel {
    let type: AlertType
    let title: String
    let message: String
    let actions: [AlertAction]
    
    static func getErrorModel(message: String) -> AlertModel {
        AlertModel(type: .error, title: "", message: message, actions: [.init(name: "OK", completion: {})])
    }
    
    static func getSuccessModel(message: String) -> AlertModel {
        AlertModel(type: .success, title: "", message: message, actions: [.init(name: "OK", completion: {})])
    }
}

struct AlertView: View {
    
    let model: AlertModel
    
    var body: some View {
        
        GeometryReader { proxy in
            ZStack {
                Rectangle()
                    .background(.green)
                VStack(spacing: 0) {
                    Rectangle()
                        .foregroundStyle(model.type.getColor())
                        .frame(height: 40)
                        .overlay {
                            Text((!model.title.isEmpty ? model.title : model.type.rawValue).uppercased())
                        }
                    Rectangle()
                        .frame(height: 2)
                        .foregroundStyle(.black)
                    
                    model.type.getImage()
                        .padding(.top, 10)
                    
                    Text(model.message)
                        .font(.system(size: 14))
                        .foregroundStyle(.textInfo)
                        .padding(16)
                    
                    
                    if model.actions.isEmpty {
                        getAction(action: .init(name: "OK", completion: {}))
                            .padding([.horizontal, .bottom], 16)
                            .padding(.bottom, 26)
                    } else if model.actions.count > 2 {
                        VStack(spacing: 10) {
                            getActions()
                        }.padding([.horizontal, .bottom], 16)
                            .padding(.bottom, 26)
                    } else {
                        HStack(spacing: 14) {
                            getActions()
                        }.padding(.horizontal, 16)
                            .padding(.bottom, 26)
                    }
                }.background(.background1)
                    .frame(width: proxy.size.width * 0.9)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .overlay {
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(.black, lineWidth: 1)
                    }
            }
        }
        
    }
    
    @ViewBuilder
    private func getActions() -> some View {
        ForEach(model.actions) {
            getAction(action: $0)
        }
    }
    
    @ViewBuilder
    private func getAction(action: AlertAction) -> some View {
        Rectangle()
            .fill(model.type.getColor())
            .modifier(ShadowModifier(foregroundColor: .background1, cornerRadius: 17))
            .frame(width: 150, height: 34)
            .overlay {
                Text(action.name)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(.textDark)
            }
            .onTapGesture {
                action.completion()
            }
    }
}

#Preview {
    AlertView(model: .init(type: .warning, title: "WTF???", message: "ksdka aksdl m?", actions: [.init(name: "first", completion: {}), .init(name: "second", completion: {})]))
}
