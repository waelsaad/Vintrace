//
//  ButtonStyles.swift
//  Library
//
//  Created by Wael Saad on 23/6/2022.
//  Copyright © 2022 NetTrinity. All rights reserved.
//

import SwiftUI

enum ButtonState {
    case enabled
    case pressed
    case loading
    case disabled
}

extension View {

    func style(
        foreground: Color = Color.white,
        primaryImage: AppImage? = nil,
        secondaryImage: AppImage? = nil,
        systemName: String? = nil,
        systemImage: SystemImage? = nil,
        _ style: ImageStyle = .standard
    ) -> some View {
        self.buttonStyle(
            ButtonImage(
                primaryImage: primaryImage,
                secondaryImage: secondaryImage,
                systemName: systemName,
                systemImage: systemImage,
                foreground: foreground,
                style: style,
                width: UI.ImageSize.xsmall,
                height: UI.ImageSize.xsmall
            )
        )
    }
    
    func editStyleX(progress: CGFloat) -> some View {
        self.buttonStyle(ButtonImage(primaryImage: .edit, secondaryImage: .edit_clear, progress: progress, width: 73.0, height: 30.0))
    }
    
    func editStyle(progress: CGFloat) -> some View {
        self.buttonStyle(CapsuleButtonStyle(imageName: AppImage.pencil, text: GlobalContent.editTitle, progress: progress))
    }
    
    func moreStyle(progress: CGFloat) -> some View {
        self.buttonStyle(CircleButtonStyle(imageName: SystemImage.ellipsis.rawValue, progress: progress))
    }
    
    func backStyle(progress: CGFloat) -> some View {
        self.buttonStyle(CircleButtonStyle(imageName: SystemImage.chevronLeft.rawValue, progress: progress))
    }
    
}
