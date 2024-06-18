//
//  CardView.swift
//  Library
//
//  Created by Wael Saad on 26/02/2024.
//  Copyright © 2022 NetTrinity. All rights reserved.
//

import SwiftUI

struct CardView<Content: View>: View {
    
    var content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .padding()
            .background(Color.white)
            .cornerRadius(16)
            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 3, y: 0)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
            )
    }
    
}

struct CardView2<Content>: View where Content: View {
    
    var content: Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.white)
                .mask {
                    RoundedRectangle(cornerRadius: 16)
                }
                .shadow(color: Color.black.opacity(0.2), radius: 3, y: 0)
            content
        }
    }
    
}

struct CardView3<Content>: View where Content: View {
    var content: Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        ZStack {
//            RoundedRectangle(cornerRadius: 16)
//                .fill(Color.white)
//                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 0)
            
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 0)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .padding(1)
            
            content
        }
    }
    
    var bodyX: some View {
        ZStack {
//            RoundedRectangle(cornerRadius: 16)
//                .fill(Color.white)
//                .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: -5)
            
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.gray.opacity(0.5), lineWidth: 0.5)
                .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: -5)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .padding(1)
            
            content
        }
    }
}
