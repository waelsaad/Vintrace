//
//  View+Align.swift
//  Library
//
//  Created by Wael Saad on 20/6/2022.
//  Copyright © 2022 NetTrinity. All rights reserved.
//

import SwiftUI

enum ViewAlignment {
    case top
    case bottom
    case leading
    case centerX
    case trailing
    case centerY
}

extension View {

    /// Positions this view within an invisible frame having the specified alignment.
    /// - Parameter alignment: The alignment of this view inside the resulting frame.

    @ViewBuilder
    func align(_ alignment: ViewAlignment) -> some View {
        switch alignment {
        case .leading:
            self.frame(maxWidth: .infinity, alignment: .leading)
        case .trailing:
            self.frame(maxWidth: .infinity, alignment: .trailing)
        case .top:
            self.frame(maxHeight: .infinity, alignment: .top)
        case .bottom:
            self.frame(maxHeight: .infinity, alignment: .bottom)
        case .centerX:
            frame(maxWidth: .infinity, alignment: .center)
        case .centerY:
            frame(maxHeight: .infinity, alignment: .center)
        }
    }
}

struct AlignDemoView: View {

    var alignment: ViewAlignment

    var body: some View {
        Text("Hello, World!").align(alignment)
    }
}

struct AlignDemoView_Previews: PreviewProvider {

    private static var alignments: [(name: String, alignment: ViewAlignment)] = [
        (name: "Leading", alignment: .leading),
        (name: "CenterX", alignment: .centerX),
        (name: "Trailing", alignment: .trailing),
        (name: "Top", alignment: .top),
        (name: "CenterY", alignment: .centerY),
        (name: "Bottom", alignment: .bottom)
    ]

    static var previews: some View {
        ForEach(alignments, id: \.name) {
            AlignDemoView(alignment: $0.alignment)
                .previewDisplayName($0.name)
        }
    }
}
