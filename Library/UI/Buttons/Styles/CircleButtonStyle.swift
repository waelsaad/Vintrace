//
//  CircleButtonStyle.swift
//  Library
//
//  Created by Wael Saad on 26/02/2024.
//  Copyright © 2022 NetTrinity. All rights reserved.
//

import SwiftUI

struct CircleButtonStyle: ButtonStyle {
    
    var imageName: String
    var foregroundExpanded = Color.accentColor
    var foregroundCollapsed = Color.white
    var backgroundExpanded = Color.white
    var backgroundCollapsed = Color.Button.catalan
    var imageSize: CGFloat = 13
    var circleBackgroundSize: CGFloat = 30
    var progress: CGFloat = 1
    
    func makeBody(configuration: Configuration) -> some View {
        let isPressed = configuration.isPressed
        return ZStack {
            Circle()
                // .fill(backgroundExpanded)
                .fill(isPressed ? .white.opacity(UI.Opacity.pressedButton) : backgroundExpanded)
            Circle()
                // .fill(backgroundCollapsed.opacity(progress))
                .fill(isPressed ? backgroundExpanded.opacity(UI.Opacity.pressedButton) : backgroundCollapsed.opacity(progress))
        }
        .overlay(
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .frame(width: imageSize, height: imageSize)
                .foregroundColor(progress == 0 ? foregroundExpanded : foregroundCollapsed)
                .padding(10)
        )
        .frame(width: circleBackgroundSize, height: circleBackgroundSize)
    }
    
}
