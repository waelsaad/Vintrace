//
//  Int+.swift
//  Library
//
//  Created by Wael Saad on 26/2/2024.
//  Copyright © 2022 NetTrinity. All rights reserved.
//

import Foundation

extension Int {
    
    // swiftlint:disable legacy_objc_type
    
    func withSeparator() -> String {
        NumberFormatter.localizedString(from: NSNumber(value: self), number: .decimal)
    }

}
