//
//  Image+.swift
//  Library
//
//  Created by Wael Saad on 20/6/2022.
//  Copyright © 2022 NetTrinity. All rights reserved.
//

import SwiftUI

struct AppIcon: View {

    var body: some View {
        // swiftlint:disable:next object_literal
        Image(uiImage: UIImage(named: "AppIcon") ?? UIImage())
            .clipShape(RoundedRectangle(cornerRadius: UI.CornerRadius.container))
    }
}

extension Image {
    
    init(appImage: AppImage) {
        self.init(appImage.rawValue)
    }
    
    init(systemImage: SystemImage) {
        self.init(systemName: systemImage.rawValue)
    }
    
    func centerCropped() -> some View {
        GeometryReader { geo in
            self
            .resizable()
            .scaledToFill()
            .frame(width: geo.size.width, height: geo.size.height)
            .clipped()
        }
    }
    
    func resizableImage(width: CGFloat, height: CGFloat, _ color: Color) -> some View {
        self.renderingMode(.template)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: width, height: height)
            .foregroundColor(color)
    }
    
    func resizableImage(width: CGFloat, _ color: Color) -> some View {
        self.renderingMode(.template)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: width)
            .foregroundColor(color)
    }
    
    func resizableImage(height: CGFloat, _ color: Color) -> some View {
        self.renderingMode(.template)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: height)
            .foregroundColor(color)
    }
    
}
