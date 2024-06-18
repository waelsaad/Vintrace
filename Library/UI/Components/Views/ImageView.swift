//
//  ImageView.swift
//  Library
//
//  Created by Wael Saad on 27/01/2023.
//  Copyright © 2022 NetTrinity. All rights reserved.
//

import SwiftUI

enum ImageStyle {
    case standard
    case circular
    case hasTitle
}

enum ImageType {
    case app
    case name
    case system
}

struct ImageView: View {
    
    var type: ImageType
    
    var progress: CGFloat = 0
    var primaryImage: AppImage?
    var secondaryImage: AppImage?
    
    var systemName: String?
    var systemImage: SystemImage?
    
    var title: String = .empty
    
    var foreground: Color = .accentColor
    var style: ImageStyle? = .standard
    
    var width: CGFloat = 30
    var height: CGFloat = 30
    var size: CGFloat = 30
   
    var radius = 30.0
    var circleColor: Color = .orange
    
    var squareSide: CGFloat {
        2.0.squareRoot() * radius
    }
    
    init(
        primaryImage: AppImage,
        secondaryImage: AppImage,
        progress: CGFloat = 0,
        title: String = .empty,
        style: ImageStyle? = .standard,
        foreground: Color = .accentColor,
        width: CGFloat = UI.ImageSize.iconSize,
        height: CGFloat = UI.ImageSize.iconSize
    ) {
        self.type = .app
        self.title = title
        self.style = style
        self.width = width
        self.height = height
        self.progress = progress
        self.foreground = foreground
        
        self.primaryImage = primaryImage
        self.secondaryImage = secondaryImage
        
        if !title.isEmpty { self.style = .hasTitle }
    }
    
    init(
        systemName: String,
        title: String = .empty,
        style: ImageStyle? = .standard,
        foreground: Color = .red,
        size: CGFloat = UI.ImageSize.xxxsmall
    ) {
        self.type = .name
        self.style = style
        self.foreground = foreground
        self.systemName = systemName
        if !title.isEmpty { self.style = .hasTitle }
    }
    
    init(
        systemImage: SystemImage,
        title: String = .empty,
        style: ImageStyle? = .standard,
        foreground: Color = .red,
        dimension: CGFloat = UI.ImageSize.xxxsmall
    ) {
        self.type = .system
        self.style = style
        self.foreground = foreground
        self.systemImage = systemImage
        if !title.isEmpty { self.style = .hasTitle }
    }
    
    var body: some View {
        switch style {
        case .standard:
            imageView
        case .circular:
            circleImageView
        case .hasTitle:
            imageTitleView
        default:
            imageView
        }
    }
    
    @ViewBuilder
    private var imageView: some View {
        switch type {
        case .app:
            appImageView
        case .name:
            systemNameView
        case .system:
            systemImageView
        }
    }
    
}

extension ImageView {
    
    private var appImageViewX: some View {
        // Image(appImage: ((progress == 0 ? primaryImage : secondaryImage) ?? .defaultImage))
        Image("edit_clear")
            .resizable()
            .renderingMode(.template)
            // .aspectRatio(contentMode: .fit)
            .foregroundColor(foreground)
            .frame(width: width, height: height)
            // .background(.yellow)
            // .background(Color.yellow.opacity(progress))
    }
    
    private var appImageView: some View {
        Image("edit_clear")
            .resizable()
            .renderingMode(.template)
            .foregroundColor(foreground)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 15))
    }

    private var background: Color {
        progress == 0 ? .white : .Button.catalan
    }
    
    private var systemNameView: some View {
        Image(systemName: systemName ?? .defaultImage)
            .accessibilityHidden(true)
            .font(.system(size: size, weight: .medium, design: .default))
            .frame(width: width, height: height)
    }
    
    private var systemImageView: some View {
        Image(systemImage: systemImage ?? .defaultImage)
            .resizable()
            .renderingMode(.template)
            .foregroundColor(foreground)
            .frame(width: width, height: height)
    }
    
}

// MARK: icon inside circle

extension ImageView {
    
    var circleView: some View {
        Circle()
            .fill(circleColor)
            .frame(width: radius * 2, height: radius * 2)
    }
    
    var circleImageView: some View {
        ZStack {
            circleView
            imageView
        }
    }
    
}

// MARK: Image next to title

extension ImageView {
    
    var titleView: some View {
        Text(title)
            // .fontWeight(.heavy)
			.foregroundColor(.red)
            .font(.system(size: 18, weight: .regular, design: .default))
    }
    
    var imageTitleView: some View {
        HStack {
            imageView
            titleView
        }
        .padding(.leading, 15)
    }
    
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {

        ImageView(systemName: "heart.fill")
            .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
            .previewDisplayName("System Name - Standard Style")

        ImageView(systemImage: .circleFill)
            .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
            .previewDisplayName("System Image - Standard Style")
        
    }
}
