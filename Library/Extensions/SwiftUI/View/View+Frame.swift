//
//  View.CustomFrames.swift
//  Library
//
//  Created by Wael Saad on 26/11/2020.
//  Copyright © 2022 NetTrinity. All rights reserved.
//

import SwiftUI

// MARK: - Custom View Frames

extension View {
    
    /// Positions this view within an invisible frame with the specified size.
    /// - Parameters:
    ///   - size: The fixed size of the resulting view.
    ///   - alignment: The alignment of this view inside the resulting view. alignment applies if this view is smaller than the size given by the resulting frame.
    /// - Returns: A view with fixed size unless a nil size is provided.
    
    func frame(_ size: CGSize?, alignment: Alignment = .center) -> some View {
        self.frame(width: size?.width, height: size?.height, alignment: alignment)
    }
    
    /// Positions this view within an invisible frame with the specified size with a set .center alignment.
    /// - Parameters:
    ///   - width: A fixed width for the resulting view. If `width` is `nil`,
    ///     the resulting view assumes this view's sizing behavior.
    ///   - height: A fixed height for the resulting view. If `height` is `nil`,
    ///     the resulting view assumes this view's sizing behavior.
    ///
    /// - Returns: A view with fixed dimensions of `width` and `height`, for the
    ///   parameters that are non-`nil`.
    
    func frame(width: CGFloat, height: CGFloat) -> some View {
        self.frame(width: width, height: height, alignment: .center)
    }
    
    /// Positions this view within an invisible frame with the specified size with a set .center alignment.
    /// - Parameter square: A fixed width and height for the resulting view. If `width` is `nil`, the resulting view assumes this view's sizing behavior.
    /// - Returns: A square view with fixed dimensions of `width` and `height`.
    
    func frame(square: CGFloat) -> some View {
        self.frame(width: square, height: square, alignment: .center)
    }
    
    func frame(size: Double) -> some View {
        frame(width: size, height: size)
    }
    
    /// Positions the view within an invisible frame with the specified size.
    ///
    ///     myView.frame(size: CGSize(width: 100, height: 100))
    ///
    /// - Returns: A view with fixed dimensions of width and height
    ///  @inlinable
    
    func frame(size: CGSize) -> some View {
        frame(width: size.width, height: size.height)
    }
    
    /// Positions this `View` within an invisible frame with the specified dimension.
    ///
    ///     var body: some View {
    ///         Color.accentColor
    ///             .frame(dimension: 100)
    ///     }

    func frame(
        _ dimension: CGFloat,
        alignment: Alignment = .center
    ) -> some View {
        frame(
            width: dimension, height: dimension,
            alignment: alignment
        )
    }
    
    /// Positions this `View` within an invisible frame with the specified size.
    ///
    ///     var body: some View {
    ///         Color.accentColor
    ///             .frame(size: .init(dimension: 100))
    ///     }

    func frame(
        size: CGSize,
        alignment: Alignment = .center
    ) -> some View {
        frame(
            width: size.width,
            height: size.height,
            alignment: alignment
        )
    }

}
