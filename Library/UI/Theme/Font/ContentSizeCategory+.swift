//
//  Fonts+.swift
//  Library
//
//  Created by Wael Saad on 20/6/2022.
//  Copyright © 2022 NetTrinity. All rights reserved.
//

import SwiftUI

extension ContentSizeCategory {
    
    var size: CGFloat {
        switch self {
        case .small:
            return 10
        case .medium:
            return 12
        case .large:
            return 20
        case .extraLarge:
            return 30
        case .extraExtraLarge:
            return 40
        default:
            return 14
        }
    }
    
}
