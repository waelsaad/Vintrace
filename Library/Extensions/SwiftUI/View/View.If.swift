//
//  View.If.swift
//  Library
//
//  Created by Wael Saad on 26/11/2020.
//  Copyright © 2022 NetTrinity. All rights reserved.
//

import SwiftUI

// MARK: - Conditional View Modifiers

extension View {
 
    @inlinable
    func `if`<Content: View>(
        _ conditional: Bool,
        then: (Self) -> Content
    ) -> TupleView<(Self?, Content?)> {
        if conditional {
            return TupleView((nil, then(self)))
        }
        return TupleView((self, nil))
    }

    @ViewBuilder
    func `if`(
        _ condition: Bool,
        ifTransform: (Self) -> some View,
        elseTransform: (Self) -> some View
    ) -> some View {
        if condition {
            ifTransform(self)
        } else {
            elseTransform(self)
        }
    }

    @inlinable
    func `if`<A: View, B: View>(
        _ conditional: Bool,
        then: (Self) -> A,
        `else`: (Self) -> B
    ) -> TupleView<(A?, B?)> {
        if conditional {
            return TupleView((then(self), nil))
        }
        return TupleView((nil, `else`(self)))
    }
    
}
