//
//  FileName.swift
//  Macrokey
//
//  Created by Wael Saad on 25/9/2022.
//  Copyright © 2022 NetTrinity. All rights reserved.
//

import Foundation
import SwiftUI

enum FileName: String {
    
	case stockItem1 = "stock-item-1"
    case stockItem2 = "stock-item-2"
    case stockItem3 = "stock-item-3"
    case stockItem4 = "stock-item-4"
    case stockItem5 = "stock-item-5"
    
    var value: String {
        rawValue
    }

}
