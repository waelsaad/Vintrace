//
//  NavLinkStyle.swift
//  Library
//
//  Created by Wael Saad on 19/7/2022.
//  Copyright © 2022 NetTrinity. All rights reserved.
//

import SwiftUI

struct NavLinkStyle: ButtonStyle {

    @Environment(\.isEnabled) var isEnabled
    @Environment(\.colorScheme) var colorScheme
    
    let isInSheet: Bool
    let showDivider: Bool

    func makeBody(configuration: Configuration) -> some View {
        VStack(spacing: 0) {
            configuration.label
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                // .background(isInSheet ? Color.infoCardBackgroundInSheet : Color.navLinkBackground)
                .foregroundColor(colorScheme == .dark ? .white : .black)
                .multilineTextAlignment(.leading)

            if showDivider {
                // Divider()
                Color.navLinkDivider.frame(height: 2).opacity(0.3)
            }
        }
    }
    
}

extension View {
    func navLink(isInSheet: Bool, showDivider: Bool = false) -> some View {
        self.buttonStyle(NavLinkStyle(isInSheet: isInSheet, showDivider: showDivider))
    }
}
