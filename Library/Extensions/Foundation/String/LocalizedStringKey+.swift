//
//  LocalizedStringKey+.swift
//  Library
//
//  Created by Wael Saad on 20/6/2022.
//  Copyright © 2022 NetTrinity. All rights reserved.
//

// swiftlint:disable force_unwrapping nslocalizedstring_key

import SwiftUI

func localized(_ key: String) -> String { NSLocalizedString(key, comment: "") }
func localized(_ key: String, arguments: CVarArg...) -> String { String(format: localized(key), arguments: arguments) }

extension LocalizedStringKey {
    
    static var empty: LocalizedStringKey { "" }
    
    var stringKey: String {
        let description = "\(self)"

        let components = description.components(separatedBy: "key: \"")
            .map { $0.components(separatedBy: "\",") }

        return components[1][0]
    }

    var value: String {
        .localizedString(for: self.stringKey, locale: .current)
    }

}

extension String {
    
    /// Localized string.
    ///
    /// - Returns: Localized string.
    
    var localized: String {
        NSLocalizedString(self, comment: .empty)
    }
    
    /// Localized string.
    ///
    /// - Parameters:
    ///   - arguments: Positional arguments in string.
    /// - Returns: Localized string.
    
    func localized(_ arguments: CVarArg...) -> String {
        String(format: self.localized, arguments: arguments)
    }
    
    static func localizedString(for key: String, locale: Locale = .current) -> String {
        let language = locale.language.languageCode?.identifier
        let path = Bundle.main.path(forResource: language, ofType: "lproj")!
        let bundle = Bundle(path: path)!
        let localizedString = NSLocalizedString(key, bundle: bundle, comment: .empty)

        return localizedString
    }

}
