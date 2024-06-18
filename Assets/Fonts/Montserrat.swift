//
//  Montserrat.swift
//  Vintrace
//
//  Created by Wael Saad on 25/2/2024.
//  Copyright © 2022 NetTrinity. All rights reserved.
//

import SwiftUI

extension Font {
    
    enum montserrat: FontStyle {
       
        case italic
        case light
        case regular
        case bold
        case semibold
        case ultraLight

        static let lightFontSize = Font.custom(Self.light.name, size: 10, relativeTo: .title)
        static let regularFontSize = Font.custom(Self.regular.name, size: 10, relativeTo: .title)
        static let mediumFontSize = Font.custom(Self.regular.name, size: 14, relativeTo: .title)
        static let semiboldFontSize = Font.custom(Self.semibold.name, size: 10, relativeTo: .title)
        static let boldFontSize = Font.custom(Self.ultraLight.name, size: 12, relativeTo: .title)
        
        var name: String {
            switch self {
            case .bold: return "Montserrat-Bold"
            case .italic: return "Montserrat-Italic"
            case .light: return "Montserrat-Light"
            case .regular: return "Montserrat-Regular"
            case .semibold: return "Montserrat-SemiBold"
            case .ultraLight: return "Montserrat-UltraLight"
            }
        }

        static func italic(size: CGFloat, relativeTo textStyle: Font.TextStyle? = nil) -> Font {
            italic.font(size: size, relativeTo: textStyle)
        }
        
        static func light(size: CGFloat, relativeTo textStyle: Font.TextStyle? = nil) -> Font {
            light.font(size: size)
        }

        static func regular(size: CGFloat, relativeTo textStyle: Font.TextStyle? = nil) -> Font {
            regular.font(size: size, relativeTo: textStyle)
        }

        static func semibold(size: CGFloat, relativeTo textStyle: Font.TextStyle? = nil) -> Font {
            semibold.font(size: size, relativeTo: textStyle)
        }

        static func ultraLight(size: CGFloat, relativeTo textStyle: Font.TextStyle? = nil) -> Font {
            ultraLight.font(size: size, relativeTo: textStyle)
        }
        
        static func bold(size: CGFloat, relativeTo textStyle: Font.TextStyle? = nil) -> Font {
            bold.font(size: size, relativeTo: textStyle)
        }
        
    }

}

// MARK: - Usage:

// Text("Hello, Wael!")
//     .font(.Montserrat.font(.light, size: 16))
//    .font(.Montserrat.light(size: 16))
//     .font(.Montserrat.light(size: 16, relativeTo: .body))
// Or
// Font.Montserrat.medium.font(size: 75).uiFont
