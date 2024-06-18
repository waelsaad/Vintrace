//
//  String+.swift
//  Library
//
//  Created by Wael Saad on 20/6/2022.
//  Copyright © 2022 NetTrinity. All rights reserved.
//

import Foundation

extension String {
    
    static let empty = ""

    var data: Data { Data(self.utf8) }
    
    static var defaultImage: String {
        "defaultImage"
    }
    
    static var defaultValue: String {
        String()
    }
    
}
