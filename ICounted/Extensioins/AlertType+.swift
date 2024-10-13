//
//  AlertType+.swift
//  ICounted
//
//  Created by Nebo on 13.10.2024.
//

import SwiftUI

extension AlertType {
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
