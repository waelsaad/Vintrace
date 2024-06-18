//
//  Position.swift
//  Library
//
//  Created by Wael Saad on 20/6/2022.
//  Copyright © 2022 NetTrinity. All rights reserved.
//

import SwiftUI

enum Position {
    
    case top
    case bottom
    case middle
    case lonesome
    
    var showDivider: Bool {
        switch self {
        case .top, .middle: return true
        case .lonesome, .bottom: return false
        }
    }
    
    var roundedCorners: UIRectCorner {
        switch self {
        case .top: return [.topLeft, .topRight]
        case .lonesome: return [.allCorners]
        case .bottom: return [.bottomLeft, .bottomRight]
        case .middle: return []
        }
    }
    
    static func calculate(index: Int, totalItems: Int) -> Position {
        if totalItems > 1 {
            if index == 0 {
                return .top
            } else if index == totalItems - 1 {
                return .bottom
            } else {
                return .middle
            }
        } else {
            return .lonesome
        }
    }
    
}
