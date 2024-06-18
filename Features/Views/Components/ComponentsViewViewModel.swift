//
//  ComponentsViewViewModel.swift
//  Vintrace
//
//  Created by Wael Saad on 26/2/2024.
//  Copyright © 2022 NetTrinity. All rights reserved.
//

import SwiftUI

extension ComponentsView {
    
    final class ComponentsViewModel: ObservableObject {
        
        // MARK: Published properties
        
        @Published var stockItem: StockItem
        
        // MARK: Computed properties
        
        var components: [Component] { stockItem.components }
        
        var componentsCount: String { "(\(components.count))" }
        
        // MARK: Init
        
        init(stockItem: StockItem) {
            self.stockItem = stockItem
        }
        
        // MARK: Methods
        
    }
    
}
