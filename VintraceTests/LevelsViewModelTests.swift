//
//  LevelsViewModelTests.swift
//  Vintrace
//
//  Created by Wael Saad on 17/2/2024.
//  Copyright © 2022 NetTrinity. All rights reserved.
//

import XCTest
import SwiftUI
@testable import Vintrace

final class LevelsViewModelTests: XCTestCase {

    // swiftlint:disable implicitly_unwrapped_optional
    
    private typealias ViewModel = LevelsView.LevelsViewModel
    
    private var viewModel: ViewModel!
    private var stockItem: StockItem!
    
    private let quantity = Quantity(onHand: 10, committed: 5, ordered: 3)
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        stockItem = StockItem(id: 1, code: "ABC123", description: "Test Item", secondaryDescription: nil, type: BeverageType(name: "Test", code: "TST"), beverageProperties: nil, unit: Unit(name: "Test Unit", description: "Test Description", abbreviation: "TU", precision: 2), unitRequired: true, quantity: quantity, owner: Owner(id: 1, name: "Owner"), images: [], components: [])
        viewModel = ViewModel(stockItem: stockItem)
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        try super.tearDownWithError()
    }
    
    func testAvailableCalculation() {
        
        // Given
        let viewModel = LevelsView.LevelsViewModel(stockItem: stockItem)
        
        // When
        let available = viewModel.available
        
        // Then
        XCTAssertEqual(available, 8) // (10 + 3) - 5 = 8
    }
    
    func testLevelsSetup() {
        // Given
        let quantity = Quantity(onHand: 10, committed: 5, ordered: 3)
        let stockItem = StockItem(id: 1, code: "ABC123", description: "Test Item", secondaryDescription: nil, type: BeverageType(name: "Test", code: "TST"), beverageProperties: nil, unit: Unit(name: "Test Unit", description: "Test Description", abbreviation: "TU", precision: 2), unitRequired: true, quantity: quantity, owner: Owner(id: 1, name: "Owner"), images: [], components: [])
        
        // When
        let viewModel = LevelsView.LevelsViewModel(stockItem: stockItem)
        
        // Then
        XCTAssertEqual(viewModel.levels.count, 4)
        XCTAssertEqual(viewModel.levels[0].label, "On Hand")
        XCTAssertEqual(viewModel.levels[0].value, "10")
        XCTAssertEqual(viewModel.levels[1].label, "Committed")
        XCTAssertEqual(viewModel.levels[1].value, "5")
        XCTAssertEqual(viewModel.levels[2].label, "In production")
        XCTAssertEqual(viewModel.levels[2].value, "3")
        XCTAssertEqual(viewModel.levels[3].label, "Available")
        XCTAssertEqual(viewModel.levels[3].value, "8")
    }
    
    func testAlert() {
        // Given
        let quantity = Quantity(onHand: 10, committed: 5, ordered: 3)
        let stockItem = StockItem(id: 1, code: "ABC123", description: "Test Item", secondaryDescription: nil, type: BeverageType(name: "Test", code: "TST"), beverageProperties: nil, unit: Unit(name: "Test Unit", description: "Test Description", abbreviation: "TU", precision: 2), unitRequired: true, quantity: quantity, owner: Owner(id: 1, name: "Owner"), images: [], components: [])
        let viewModel = LevelsView.LevelsViewModel(stockItem: stockItem)
        
        // When
        viewModel.showAlert = true
        
        // Then
        XCTAssertTrue(viewModel.showAlert)
    }
    
    func testPositiveAvailableColor() {
        // Given
        let quantity = Quantity(onHand: 10, committed: 5, ordered: 3)
        let stockItem = StockItem(id: 1, code: "ABC123", description: "Test Item", secondaryDescription: nil, type: BeverageType(name: "Test", code: "TST"), beverageProperties: nil, unit: Unit(name: "Test Unit", description: "Test Description", abbreviation: "TU", precision: 2), unitRequired: true, quantity: quantity, owner: Owner(id: 1, name: "Owner"), images: [], components: [])
        let viewModel = LevelsView.LevelsViewModel(stockItem: stockItem)
        
        // When
        let textColorPositive = viewModel.getTextColor(for: LevelsView.LevelsViewModel.Level(label: "Available", value: "\(viewModel.available)"))
        
        // Then
        XCTAssertEqual(textColorPositive, .green)
    }

    func testZeroAvailableColor() {
        // Given
        let quantity = Quantity(onHand: 10, committed: 13, ordered: 3)
        let stockItem = StockItem(id: 1, code: "ABC123", description: "Test Item", secondaryDescription: nil, type: BeverageType(name: "Test", code: "TST"), beverageProperties: nil, unit: Unit(name: "Test Unit", description: "Test Description", abbreviation: "TU", precision: 2), unitRequired: true, quantity: quantity, owner: Owner(id: 1, name: "Owner"), images: [], components: [])
        let viewModel = LevelsView.LevelsViewModel(stockItem: stockItem)
        
        // When
        let textColorZero = viewModel.getTextColor(for: LevelsView.LevelsViewModel.Level(label: "Available", value: "\(viewModel.available)"))
        
        // Then
        XCTAssertEqual(textColorZero, .black)
    }

    func testNegativeAvailableColor() {
        // Given
        let quantity = Quantity(onHand: 10, committed: 20, ordered: 3)
        let stockItem = StockItem(id: 1, code: "ABC123", description: "Test Item", secondaryDescription: nil, type: BeverageType(name: "Test", code: "TST"), beverageProperties: nil, unit: Unit(name: "Test Unit", description: "Test Description", abbreviation: "TU", precision: 2), unitRequired: true, quantity: quantity, owner: Owner(id: 1, name: "Owner"), images: [], components: [])
        let viewModel = LevelsView.LevelsViewModel(stockItem: stockItem)
        
        // When
        let textColorNegative = viewModel.getTextColor(for: LevelsView.LevelsViewModel.Level(label: "Available", value: "\(viewModel.available)"))
        
        // Then
        XCTAssertEqual(textColorNegative, .red)
    }

}
