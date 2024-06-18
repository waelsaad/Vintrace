//
//  NavLinkRow.swift
//  Library
//
//  Created by Wael Saad on 12/8/2022.
//  Copyright © 2022 NetTrinity. All rights reserved.
//

import SwiftUI

struct NavLinkRow<Destination: View>: View {

    let destination: Destination
    let image: Image?
    let title: String
    var subTitle: String?
    var trailingText: String?
    let position: Position
    let color: Color?
    let isInSheet: Bool
    @Binding var isActive: Bool
    
    let onSelect: (() -> Void)?

    // swiftlint:disable function_default_parameter_at_end
    
    init(title: String, image: Image? = nil, subTitle: String? = nil, trailingText: String? = nil, color: Color? = nil, isInSheet: Bool = false, position: Position, isActive: Binding<Bool> = .constant(false), @ViewBuilder destination: () -> Destination, onSelect: (() -> Void)? = nil) {
        self.title = title
        self.subTitle = subTitle
        self.trailingText = trailingText
        self.image = image
        self.color = color
        self.position = position
        self.isInSheet = isInSheet
        self._isActive = isActive
        self.destination = destination()
        self.onSelect = onSelect
    }

    var body: some View {
        NavSegueLink(position: position, isActive: isActive ? $isActive : nil) {
            destination
        } content: {
            linkTitle
                .if(onSelect != nil) {
                    $0.onTapGesture {
                        if let onSelect {
                            onSelect()
                        }
                    }
                }
        }
    }
    
    @ViewBuilder
    private var linkTitle: some View {
        HStack {
            if let image = image, let color = color {
                BoxedImage(image: image, foregroundColour: color)
            } else if let image = image {
                BoxedImage(image: image)
            }
            VStack(alignment: .leading, spacing: .zero) {
                Text(title)
                    .foregroundColor(.Text.Component.title)
                    .font(.montserrat.regular(size: UI.FontSize.Component.title))
                    .fixedSize(horizontal: false, vertical: true)
                
                if let subTitle, !subTitle.isEmpty {
                    Spacer()
                    Text(subTitle)
                        .foregroundColor(.Text.Component.subTitle)
                        .font(.montserrat.regular(size: UI.FontSize.Component.subTitle))
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.leading)
                }
            }
            Spacer()
            if let trailingText, !trailingText.isEmpty {
                Spacer()
                Text(trailingText)
                    .foregroundColor(.Text.Component.count)
                    .font(.montserrat.regular(size: UI.FontSize.Component.unit))
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.trailing)
            }
        }
        .contentShape(Rectangle())
        .frame(maxHeight: .infinity, alignment: .center)
    }
    
}
