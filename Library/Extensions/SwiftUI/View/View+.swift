//
//  View+.swift
//  Library
//
//  Created by Wael Saad on 26/4/2024.
//  Copyright © 2022 NetTrinity. All rights reserved.
//

import SwiftUI

extension View {
    
    var anyView: AnyView {
        AnyView(self)
    }
    
    /// Type casting to AnyView
    ///
    ///     myView.toAnyView()
    ///
    /// - Returns: A view as AnyView
    @inlinable
    func toAnyView() -> AnyView {
        AnyView(self)
    }
    
    /// Hides / unhides a view
    /// - Parameter shouldHide: hidden value
    /// - Returns: a view that is hidden or not
    @ViewBuilder
    func isHidden(_ shouldHide: Bool) -> some View {
        switch shouldHide {
        case true: self.hidden()
        case false: self
        }
    }
    
    /// Encapsulate view in navigation view
    ///
    ///     myView.embedInNavigation()
    ///
    /// - Returns: A view encapsulate in navigation view
    @inlinable
    func embedInNavigation1() -> some View {
        NavigationView { self }
    }
    
    @inlinable
    func embedInNavigation() -> some View {
        NavigationStack { self }
    }
    
    func background(_ hex: String) -> some View {
        self.background(Color(hex: "9265F8"))
    }
    
    func foregroundColor(_ hex: String) -> some View {
        self.foregroundColor(Color(hex: "9265F8"))
    }
    
}
