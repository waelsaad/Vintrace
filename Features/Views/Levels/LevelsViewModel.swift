//
//  LevelsView.swift
//  Vintrace
//
//  Created by Wael Saad on 26/2/2024.
//  Copyright © 2022 NetTrinity. All rights reserved.
//

import SwiftUI

extension LevelsView {
    
    final class LevelsViewModel: ObservableObject {
        
        // MARK: Enum properties
        
        struct Level {
            var label: String
            var value: String
        }
        
        // MARK: Published properties
        
        @Published var showAlert = false
        @Published var stockItem: StockItem
        
        // MARK: Exposed roperties
        
        var levels: [Level] = []
        
        // MARK: Computed properties
        
        var available: Int {
            stockItem.quantity.onHand + stockItem.quantity.ordered - stockItem.quantity.committed
        }
        
        // MARK: Init
        
        init(stockItem: StockItem) {
            self.stockItem = stockItem
            setup()
        }
        
        // MARK: Methods
        
        private func setup() {
            levels.append(Level(label: Content.onHand.value, value: "\(stockItem.quantity.onHand.withSeparator())"))
            levels.append(Level(label: Content.committed.value, value: "\(stockItem.quantity.committed.withSeparator())"))
            levels.append(Level(label: Content.inProduction.value, value: "\(stockItem.quantity.ordered.withSeparator())"))
            levels.append(Level(label: Content.available.value, value: "\(available.withSeparator())"))
        }
        
        func getTextColor(for level: Level) -> Color {
            guard
                level.label == Content.available.value 
            else {
                return .Text.Item.levelValue
            }
            
            switch available {
            case let value where value < 0:
                return .red
            case let value where value > 0:
                return .green
            default:
                return .black
            }
        }
        
    }
    
}
