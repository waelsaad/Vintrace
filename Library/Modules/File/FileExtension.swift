//
//  FileExtension.swift
//  Library
//
//  Created by Wael Saad on 24/10/2022.
//  Copyright © 2022 NetTrinity. All rights reserved.
//

import Foundation
import SwiftUI

enum FileExtension: String {
	case db
	case js
	case txt
	case css
	case ttf
	case pdf
	case mp4
	case xml
	case html
	case json
	case codepoints
	case sqlite3
	case zip

	var value: String {
		rawValue
	}

	var dotValue: String {
		"." + rawValue
	}

}
