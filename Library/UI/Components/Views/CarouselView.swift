//
//  CarouselView.swift
//  Library
//
//  Created by Wael Saad on 26/2/2024.
//  Copyright © 2022 NetTrinity. All rights reserved.
//

import SwiftUI

struct CarouselView: View {
    
    let images: [String]
    let defaultImage: AppImage
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    if images.isEmpty {
                       //  Image(defaultImage)
                        Image(appImage: defaultImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geometry.size.width, height: 600)
                            .clipped()
                    } else {
                        ForEach(images, id: \.self) { image in
                            Image(image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: geometry.size.width, height: 600)
                                .clipped()
                        }
                    }
                }
            }
            .background(Color.white)
        }
    }
    
}
