//
//  ButtonStyles+.swift
//  Library
//
//  Created by Wael Saad on 23/6/2022.
//  Copyright © 2022 NetTrinity. All rights reserved.
//

import SwiftUI

extension Button where Label == Text {
    
    init(text: LocalizedStringKey, action: @escaping () -> Void) {
        self.init(action: action) {
            Text(text)
        }
    }
    
    init(action: @escaping () -> Void) {
        self.init(action: action) {
            Text(GlobalContent.editTitle)
        }
    }
    
}

extension Button where Label == Image {
    init(iconName: String, action: @escaping () -> Void) {
        self.init(action: action) {
            Image(systemName: iconName)
        }
    }
}
