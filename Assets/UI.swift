//
//  UI.swift
//  Library
//
//  Created by Wael Saad on 20/6/2022.
//  Copyright © 2022 NetTrinity. All rights reserved.
//

import UIKit
import SwiftUI

enum InputState {
    case valid
    case enabled
    case focused
    case disabled
}

enum InputValid {
    case success
    case failure
}

enum UI {

    enum Dimensions {
        
        enum Level {
            static let rowHeight = 28.0
        }
        
        enum Component {
            static let rowHeight = 60.0
        }
        
        static let minHeight = 110.0
        static let maxHeight = 348.0
        
        static let miniHeaderHeight = 80.0
        static let circleRadius = 16.0
    }
    
    enum Space {
        
        enum ContentView {
            static let vertical = 40.0
        }
        
        static let xxSmall = 16.0
        static let xSmall = 24.0
        static let small = 36.0
        static let medium = 42.0
        static let large = 44.0
        static let xLarge = 52.0
        static let xxLarge = 80.0
        
        static let x0 = 0.0
        static let x1 = 1.0
        static let x075 = 0.75
        static let x2 = 2.0
        static let x3 = 3.0
        static let x4 = 4.0
        static let x5 = 5.0
        static let x10 = 10.0
        static let x12 = 12.0
        static let x18 = 18.0
        static let x20 = 20.0
        static let x15 = 15.0
        static let x16 = 16.0
        static let x30 = 30.0
        static let x35 = 35.0
        static let x40 = 40.0
    }
    
    enum Padding {
        
        enum Title {
            static let leading = 24.0
            static let yOffset = 40.0
        }
        
        enum HeaderView {
            static let top = 45.0
            static let bottom = 20.0
            static let leading = 10.0
            static let horizontal = 30.0
        }
        
        enum Description {
            static let bottom = 7.0
        }
        
        enum SecondaryDescription {
            static let bottom = 20.0
        }
        
        enum BeverageProperties {
            static let bottom = 20.0
        }
        
        static let boxedImage = 5.0
        static let topBarTop = 54.0
        static let titleLeading = 80.0

        static let sectionHeaderBottom = 10.0
        static let spaceBetweenIconAndText = 12.0
    }
    
    enum FontSize {
        
        enum Component {
            static let title = 15.0
            static let subTitle = 13.0
            static let unit = 15.0
        }
        
        static let title = 28.0
        static let titleInNavigation = 18.0
        static let description = 15.0
        static let secondaryDescription = 13.0
        static let name = 13.0
        static let level = 15.0
        static let sectionHeader = 18.0
        static let listButton = 14.0
        static let componentCount = 16.0
    }
    
    enum CornerRadius {
        static let button = 4.0
        static let card = 5.0
        static let infoBox = 5.0
        static let container = 10.0
        static let scannerBox = 20.0
        static let brandingCorner = 30.0
    }
    
    enum Opacity {
        static let clear = 0.0
        static let superUltraLight = 0.05
        static let ultralight = 0.1
        static let light: Double = 0.2
        static let scannerBackground = 0.4
        static let pressedButton = 0.3
        static let opaque = 1.0
    }
    
    enum Offset {
        static let logoBackground = -80.0
    }
    
    enum ImageSize {
        static let xxLarge = 180.0
        static let large = 80.0
        static let medium = 50.0
        static let itemIcon = 16.0
        static let small = 40.0
        static let xsmall = 30.0
        static let xxsmall = 25.0
        static let xxxsmall = 18.0
        static let iconSize = 30.0
        static let boxedIcon = 25.0
        static let unreadBadge = 8.0
        static let cardHeader = 150.0
		static let qr = 200.0
    }
 
    enum Button {
		static let height = 55.0
		static let minHeight = 30.0
        static let padding = 20.0
        static let cornerRadius = 30.0
        static let shadowRadius = 2.0
        static let shadowYOffset = 1.0
    }

    enum Text {
        static let asSmallAsItNeeds = 0.1
        static let scannerTextFontSize = 20.0
        static let domCovidCertTimer = 16.0
    }
    
    enum CircularSpinner {
        static let large = 60.0
        static let medium = 40.0
        static let small = 17.0
    }
    
}
