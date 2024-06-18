//
//  Stock.swift
//  Vintrace
//
//  Created by Wael Saad on 25/2/2024.
//  Copyright © 2022 NetTrinity. All rights reserved.
//

import Foundation

struct StockItem: Codable {
	let id: Int
	let code: String
	let description: String
	let secondaryDescription: String?
	let type: BeverageType
	let beverageProperties: BeverageProperties?
	let unit: Unit
	let unitRequired: Bool
	let quantity: Quantity
	let owner: Owner
	let images: [BeverageImage]
	let components: [Component]
}

struct BeverageType: Codable {
	let name: String
	let code: String
}

struct BeverageProperties: Codable {
	let colour: String?
	let description: String?
}

struct Unit: Codable {
	let name: String?
	let description: String?
	let abbreviation: String
	let precision: Int
}

struct Quantity: Codable {
	let onHand: Int
	let committed: Int
	let ordered: Int
}

struct Owner: Codable {
	let id: Int
	let name: String
}

struct BeverageImage: Codable, Hashable {
	let endpoint: String
}

struct Component: Codable {
	let endpoint: String
	let id: Int
	let code: String
	let description: String
	let unit: Unit?
	let unitRequired: Bool
	let quantity: Int
}

extension Component {
    
    var displayUnit: String? {
        guard unitRequired else { return "\(quantity)" }
        return "\(quantity) \(unit?.abbreviation ?? "")"
    }
    
    var itemId: Int? {
            if let lastComponent = endpoint.components(separatedBy: "/").last,
               let itemId = Int(lastComponent) {
                return itemId
            } else {
                return nil
            }
        }
    
}

extension StockItem {
    
    var imageNames: [String] {
        images.map { image in
            let components = image.endpoint.components(separatedBy: "/")
            return components.last ?? ""
        }
    }
    
}
