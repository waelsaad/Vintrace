//
//  Safari.swift
//  Library
//
//  Created by Wael Saad on 28/6/2022.
//  Copyright © 2022 NetTrinity. All rights reserved.
//

import SwiftUI
import SafariServices

struct SafariView: UIViewControllerRepresentable {

    let url: URL

    func makeUIViewController(
        context: UIViewControllerRepresentableContext<SafariView>
    ) -> SFSafariViewController {
        SFSafariViewController(url: url)
    }

    func updateUIViewController(
        _ uiViewController: SFSafariViewController,
        context: UIViewControllerRepresentableContext<SafariView>
    ) {

    }

}

struct FullSafariBrowserModifier: ViewModifier {
    
    let url: URL?
    @Binding var isPresented: Bool

    func body(content: Content) -> some View {
        Button {
            isPresented = true
        } label: {
            content
        }
        .fullScreenCover(isPresented: $isPresented) {
            if let url = url {
                SafariView(url: url)
            } else {
                EmptyView()
            }
        }
    }
    
}

extension View {
    
    func fullSafariBrowser(url: URL?, isPresented: Binding<Bool>) -> some View {
        self.modifier(FullSafariBrowserModifier(url: url, isPresented: isPresented))
    }
    
}
