//
//  ButtonImage.swift
//  Library
//
//  Created by Wael Saad on 23/6/2022.
//  Copyright © 2022 NetTrinity. All rights reserved.
//

import SwiftUI

struct ButtonImage: ButtonStyle {

    var systemName: String?
    
    var primaryImage: AppImage?
    var secondaryImage: AppImage?
    
    var systemImage: SystemImage?

    var style: ImageStyle = .standard
    
    private var progress = 0.0
    private var foreground = Color.accentColor
    private var background = Color.white.opacity(0.3)

    private var width: CGFloat = UI.ImageSize.xsmall
    private var height: CGFloat = UI.ImageSize.xsmall
	private var size: CGFloat = UI.ImageSize.large

    init(
        primaryImage: AppImage? = nil,
        secondaryImage: AppImage? = nil,
        systemName: String? = nil,
        systemImage: SystemImage? = nil,
        foreground: Color = .accent,
        background: Color = .white.opacity(0.3),
        progress: CGFloat = 1,
        style: ImageStyle = .standard,
        size: CGFloat = UI.ImageSize.iconSize,
        width: CGFloat? = UI.ImageSize.xsmall,
        height: CGFloat? = UI.ImageSize.xsmall
    ) {
        self.style = style

        self.size = size
        self.width = width ?? self.width
        self.height = height ?? self.height

        self.foreground = foreground
        self.background = background

        self.primaryImage = primaryImage
        self.secondaryImage = secondaryImage
        
        self.systemName = systemName
        self.systemImage = systemImage
    }
    
    private var type: ImageType {
        switch (primaryImage, systemName, systemImage) {
        case (.some, _, _):
            return .app
        case (_, .some, _):
            return .name
        case (_, _, .some):
            return .system
        default:
            return .app
        }
    }
    
    @ViewBuilder
    private var imageView: some View {
        switch type {
        case .app:
            ImageView(primaryImage: primaryImage ?? .defaultImage, secondaryImage: secondaryImage ?? .defaultImage, progress: progress, style: style, foreground: foreground, width: width, height: height)
        case .name:
            ImageView(systemName: systemName ?? .defaultImage, style: style, foreground: foreground, size: size)
        case .system:
            ImageView(systemName: systemName ?? .defaultImage, style: style, foreground: foreground, size: size)
        }
    }

    @ViewBuilder
    func makeBody(configuration: Configuration) -> some View {
        imageView
            .frame(width: width, height: height)
			.foregroundColor(configuration.isPressed ? foreground.opacity(UI.Opacity.pressedButton) : foreground)
    }
    
}
