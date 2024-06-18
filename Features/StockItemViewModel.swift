//
//  StockViewModel.swift
//  Vintrace
//
//  Created by Wael Saad on 25/2/2024.
//  Copyright © 2022 NetTrinity. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

extension StockItemScene {

	final class StockItemViewModel: ObservableObject {

        // MARK: Published properties
        
        @Published var showAlert = false
        @Published var showBrowser = false
		@Published var stockItem: StockItem?

        // MARK: Private properties
        
        private var itemId: Int?
        
        // MARK: Exposed properties
        
        var url: URL? { URL(string: Constants.url) }
        
        // MARK: Computed properties
        
        var fileName: String {
            guard let itemId = itemId else { return FileName.stockItem1.value }
            return FileName(rawValue: "stock-item-\(itemId)")?.value ?? FileName.stockItem1.value
        }
        
        // MARK: Init
        
        init(itemId: Int?) {
            self.itemId = itemId
            fetchData(itemId: itemId)
        }
        
        // MARK: Methods

        func fetchData(itemId: Int?) {
            
            // This will load the first Json and allow to dynamically load the one in component endpoint.
            stockItem = StockItem.decode(fileName: fileName)
            
            // You may directly load a different file like this
            // stockItem = StockItem.decode(fileName: FileName.stockItem2.value)
            
        }
		
	}

}
