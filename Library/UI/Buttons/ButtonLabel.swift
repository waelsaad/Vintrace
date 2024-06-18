//
//  PrimaryButtonView.swift
//  Library
//
//  Created by Wael Saad on 20/6/2022.
//  Copyright © 2022 NetTrinity. All rights reserved.
//

import SwiftUI

enum LabelLayout {
	case vertical
	case horizontal
}

struct ButtonLabel: View {

	var text: LocalizedStringKey
	var icon: ImageView?
	var layout: LabelLayout = .horizontal

	var body: some View {
		switch layout {
		case .horizontal:
			horizontalLayout
		case .vertical:
			verticalLayout
		}
	}

	private var horizontalLayout: some View {
		Label(title: {
			Text(text)
				.foregroundColor(.white)
		}, icon: {
			icon?
				.frame(size: UI.ImageSize.xsmall)
		})
	}

	private var verticalLayout: some View {
		VStack {
			icon?
				.frame(size: UI.ImageSize.xsmall)
			Text(text)
				.font(.caption)
				.fontWeight(.semibold)
				.foregroundColor(.yellow)
		}
	}
}
