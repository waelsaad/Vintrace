//
//  Button+.swift
//  Library
//
//  Created by Wael Saad on 20/6/2022.
//  Copyright © 2022 NetTrinity. All rights reserved.
//

import SwiftUI

// swiftlint:disable function_default_parameter_at_end

extension Button where Label == Image {
	init(systemName: String, action: @escaping () -> Void) {
		self.init(action: action) { Image(systemName: systemName) }
	}
}

extension Button where Label == ButtonLabel {
	init(role: ButtonRole? = nil, action: @escaping () -> Void, @ViewBuilder buttonLabel: () -> ButtonLabel) {
		self.init(action: action) {
			buttonLabel()
		}
	}
}

extension Button where Label == ButtonLabel {
	init(role: ButtonRole? = nil, action: @escaping () -> Void, text: LocalizedStringKey, icon: ImageView) {
		self.init(role: role, action: action) {
			ButtonLabel(text: text, icon: icon)
		}
	}
}

/// A control that initiates an action.

struct ImageButton: View {

    let title: Text
    let image: Image
    let role: ButtonRole?
    let action: () -> Void
    
    init(
		_ title: LocalizedStringKey,
		image: SystemImage,
		role: ButtonRole? = nil,
		action: @escaping () -> Void
	) {
        self.title = Text(title)
        self.image = Image(systemImage: image)
        self.role = role
        self.action = action
    }
    
    /// Creates a button that generates its label from a localized string key and image resource.
    /// - Parameters:
    ///   - title: The key for the button’s localized title, that describes the purpose of the button’s action.
    ///   - image: The name of the image resource to lookup, as well as the localization key with which to label the image.
    ///   - role: An optional semantic role that describes the button. A value of nil means that the button doesn’t have an assigned role.
    ///   - action: The action to perform when the user interacts with the button.
    
    init(
		_ title: LocalizedStringKey,
		image: String,
		role: ButtonRole? = nil,
		action: @escaping () -> Void
	) {
        self.title = Text(title)
        self.image = Image(image)
        self.role = role
        self.action = action
    }
    
    /// Creates a button that generates its label from a localized string key and system symbol.
    /// - Parameters:
    ///   - title: The key for the button’s localized title, that describes the purpose of the button’s action.
    ///   - systemImage: The name of the system symbol image. Use the SF Symbols app to look up the names of system symbol images.
    ///   - role: An optional semantic role that describes the button. A value of nil means that the button doesn’t have an assigned role.
    ///   - action: The action to perform when the user interacts with the button.
    
    init(
		_ title: LocalizedStringKey,
		systemImage: String,
		role: ButtonRole? = nil,
		action: @escaping () -> Void
	) {
        self.title = Text(title)
        self.image = Image(systemName: systemImage)
        self.role = role
        self.action = action
    }
    
    var body: some View {
        Button(role: role, action: action) {
            Label(title: {
                title
            }, icon: {
                image
            })
        }
    }
	
}

struct ImageButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            ImageButton("My Bordered Button", systemImage: "figure.climbing") {
                print("Great button!")
            }
            .buttonStyle(.bordered)
            
            ImageButton("My Prominent Button", image: "qrpop.icon") {
                print("Excellent button!")
            }
            .buttonStyle(.borderedProminent)
        }
    }
}
