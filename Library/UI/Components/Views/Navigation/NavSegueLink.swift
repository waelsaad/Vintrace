//
//  NavSegueLink.swift
//  Library
//
//  Created by Wael Saad on 12/8/2022.
//  Copyright © 2022 NetTrinity. All rights reserved.
//

import SwiftUI

struct NavSegueLink<Content: View, Destination: View>: View {
    
    let destination: Destination
    let content: Content
    let position: Position
    
    private let useBindingForNav: Bool
    @Binding private var isActive: Bool
    
    init(position: Position, isActive: Binding<Bool>? = nil, @ViewBuilder destination: () -> Destination, @ViewBuilder content: () -> Content) {
        self.position = position
        if let isActive {
            self.useBindingForNav = true
            self._isActive = isActive
        } else {
            self.useBindingForNav = false
            self._isActive = .constant(false)
        }
        self.destination = destination()
        self.content = content()
    }
    
    var body: some View {
        navigationLink
            .navLink(isInSheet: true, showDivider: position.showDivider)
    }
    
    @ViewBuilder
    private var navigationLink: some View {
        navigationLinkNoBinding
    }
    
    private var navigationLinkNoBinding: some View {
        NavigationLink {
            destination
        } label: {
            label
        }
    }

    private var label: some View {
        HStack {
            content
            Spacer()
            DisclosureIndicator()
        }
        .contentShape(Rectangle())
        .frame(alignment: .center)
    }
    
}
