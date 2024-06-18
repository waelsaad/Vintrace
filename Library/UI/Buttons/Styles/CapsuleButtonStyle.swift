//
//  CapsuleButtonStyle.swift
//  Library
//
//  Created by Wael Saad on 26/02/2024.
//  Copyright © 2022 NetTrinity. All rights reserved.
//

import SwiftUI

struct CapsuleButtonStyle: ButtonStyle {
    
    var imageName: AppImage
    var text: LocalizedStringKey
    var foregroundExpanded = Color.accentColor
    var foregroundCollapsed = Color.white
    var backgroundExpanded = Color.white
    var backgroundCollapsed = Color.Button.catalan
    var imageSize: CGFloat = 11
    var cornerRadius: CGFloat = 14
    var fontSize: CGFloat = 22
    var progress: CGFloat = 1

    var capsuleWidth: CGFloat = 73
    var capsuleHeight: CGFloat = 30
    
    private var iconView: some View {
        Image(appImage: imageName)
            .resizable()
            .renderingMode(.template)
            .aspectRatio(contentMode: .fill)
            // .scaledToFit()
            .frame(width: imageSize, height: imageSize)
            .clipped()
            .foregroundColor(progress == 0 ? foregroundExpanded : foregroundCollapsed)
    }
    
    private var textView: some View {
        Text(text)
            .foregroundColor(progress == 0 ? foregroundExpanded : foregroundCollapsed)
            .font(.montserrat.light(size: 12))
    }
    
    func makeBody(configuration: Configuration) -> some View {
        let isPressed = configuration.isPressed
        return ZStack {
            Capsule()
                .fill(isPressed ? .white.opacity(UI.Opacity.pressedButton) : backgroundExpanded)
                .frame(width: capsuleWidth, height: capsuleHeight)
            Capsule()
                .fill(isPressed ? backgroundExpanded.opacity(UI.Opacity.pressedButton) : backgroundCollapsed.opacity(progress))
                .frame(width: capsuleWidth, height: capsuleHeight)
        }
        .overlay(
            HStack(spacing: 13) {
                iconView
                textView
            }
            .frame(width: capsuleWidth)
            .fixedSize(horizontal: true, vertical: false)
        )
        
    }
    
}
