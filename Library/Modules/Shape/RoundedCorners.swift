//
//  RoundedCorners.swift
//  Library
//
//  Created by Wael Saad on 20/6/2022.
//  Copyright © 2022 NetTrinity. All rights reserved.
//

import SwiftUI

struct RoundedCorner: Shape {
    
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

protocol RoundedCorners {
    var itemIndex: Int? { get }
    var totalItems: Int? { get }
}

extension RoundedCorners {
    
    var showDivider: Bool {
        guard let totalItems = totalItems, let itemIndex = itemIndex else { return false }
        return itemIndex < totalItems - 1
    }
    
    var roundedCorners: UIRectCorner {
        guard let totalItems = totalItems, let itemIndex = itemIndex else {
            return []
        }
        
        if itemIndex == 0 {
            return [.topLeft, .topRight]
        }
        if itemIndex == (totalItems - 1) {
            return [.bottomLeft, .bottomRight]
        }
        return []
    }
    
}
