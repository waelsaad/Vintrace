//
//  AppScene.swift
//  Vintrace
//
//  Created by Wael Saad on 25/2/2024.
//  Copyright © 2022 NetTrinity. All rights reserved.
//

import SwiftUI

@main
struct AppScene: App {

	@ObservedObject var viewModel = AppScene.AppViewModel()

	@UIApplicationDelegateAdaptor private var appDelegate: AppDelegate

	init() {

	}

	var body: some Scene {
		WindowGroup {
            
            // MARK: set 1 to default stock item id 1 which is stock-item-1.json
            
            NavigationView {
                StockItemScene(viewModel: .init(itemId: 1))
                    .navigationViewStyle(.stack)
            }
		}
	}

}
