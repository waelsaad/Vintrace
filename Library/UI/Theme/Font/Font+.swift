//
//  Fonts++.swift
//  Library
//
//  Created by Wael Saad on 20/6/2022.
//  Copyright © 2022 NetTrinity. All rights reserved.
//

import Swift
import SwiftUI
import UIKit

extension Font {
    
    init(_ uiFont: UIFont) {
        self = Font(uiFont as CTFont)
    }
    
	var textStyle: TextStyle? {
		switch self {
		case .largeTitle:
			return .largeTitle
		case .title:
			return .title
		case .title2:
			return .title2
		case .title3:
			return .title3
		case .headline:
			return .headline
		case .body:
			return .body
		case .callout:
			return .callout
		case .subheadline:
			return .subheadline
		case .footnote:
			return .footnote
		case .caption:
			return .caption
		case .caption2:
			return .caption2
		default:
			return .body
		}
	}

    var uiFont: UIFont {
        guard 
			let textStyle = textStyle?.toUIFontTextStyle
		else { return UIFont.systemFont(ofSize: 36) }

        return .preferredFont(forTextStyle: textStyle)
    }
    
    func toUIFont() -> UIFont? {
        guard let textStyle = textStyle?.toUIFontTextStyle else {
            return nil
        }
        
        return .preferredFont(forTextStyle: textStyle)
    }

    static func custom(_ name: String, relativeTo textStyle: Font.TextStyle) -> Font {
        func _default() -> Font {
            guard let font = UIFont(name: name, size: textStyle.defaultMetrics.size) else {
                return .body
            }
            
            let fontMetrics = UIFontMetrics(forTextStyle: textStyle.toUIFontTextStyle)
            
            return Font(fontMetrics.scaledFont(for: font))
        }
        
        return Font.custom(name, size: textStyle.defaultMetrics.size, relativeTo: textStyle)
    }
    
}

struct ScaledFont: ViewModifier {
    
    @Environment(\.sizeCategory) var sizeCategory
    var style: FontStyle
    var size: Double
    
    func body(content: Content) -> some View {
        let scaledSize = UIFontMetrics.default.scaledValue(for: size)
		return content.font(.custom(style.name, size: scaledSize))
    }
    
}

extension View {
    
    func scaledFont(style: FontStyle, size: Double) -> some View {
		self.modifier(ScaledFont(style: style, size: size))
    }
    
    func font(_ style: FontStyle, category: ContentSizeCategory) -> some View {
		self.font(.custom(style.name, size: category.size, relativeTo: .largeTitle))
    }
    
}
