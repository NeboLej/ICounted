//
//  Font.swift
//  ICounted
//
//  Created by Nebo on 04.02.2025.
//

import SwiftUI

enum MyFontType {
    case bold, extraBold, light, extraLight, regular, medium, semiBold
}

extension Font {
    
    static func myFont(type: MyFontType, size: CGFloat) -> Font {
        let fontName: String = switch type {
        case .bold:
            "ACARISANS-BOLD"
        case .extraBold:
            "ACARISANS-EXTRABOLD"
        case .light:
            "ACARISANS-LIGHT"
        case .extraLight:
            "ACARISANS-EXTRALIGHT"
        case .regular:
            "ACARISANS-REGULAR"
        case .medium:
            "ACARISANS-MEDIUM"
        case .semiBold:
            "ACARISANS-SEMIBOLD"
        }
        
        return Font.custom(fontName, fixedSize: size)
    }
    
}

