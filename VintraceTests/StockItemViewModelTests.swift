//
//  VintraceTests.swift
//  Vintrace
//
//  Created by Wael Saad on 17/2/2024.
//  Copyright © 2022 NetTrinity. All rights reserved.
//

import XCTest
@testable import Vintrace

final class StockItemViewModelTests: XCTestCase {

    // swiftlint:disable implicitly_unwrapped_optional
    
    private typealias ViewModel = StockItemScene.StockItemViewModel
    
    private var viewModel: ViewModel!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        viewModel = ViewModel(itemId: 1)
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        try super.tearDownWithError()
    }
    
    func testFetchDataSuccessWithValidItemID() {
        
        // Given
        let stockItemEndpoint = 1
        let expectation = XCTestExpectation(description: "Fetch data success")
        
        // When
        viewModel.fetchData(itemId: stockItemEndpoint)
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertNotNil(self.viewModel.stockItem, "Stock item should not be nil after successful fetch")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 3.0)
        
    }
    
    func testFetchDataFailureWithInvalidItemID() {
        
        // Given
        let expectation = XCTestExpectation(description: "Fetch data failure")
        
        // When
        viewModel.fetchData(itemId: nil)
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertEqual(self.viewModel.stockItem?.id, 1, "Stock item id should be 1 after failed fetch as we are loading the default one")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 3.0)
        
    }

    func testDefaultFileNameGeneration() {
        // Given
        let viewModel = ViewModel(itemId: nil)
        
        // When
        let fileName = viewModel.fileName
        
        // Then
        XCTAssertEqual(fileName, FileName.stockItem1.value, "Default file name should be 'stock-item-1'")
    }

    func testDynamicFileNameGeneration() {
        // Given
        let viewModel = ViewModel(itemId: 2)
        
        // When
        let fileName = viewModel.fileName
        
        // Then
        XCTAssertEqual(fileName, FileName.stockItem2.value, "Dynamic file name should be 'stock-item-2'")
    }
    
    func testAlertPresentation() {
        // Given
        let viewModel = ViewModel(itemId: nil)
        XCTAssertFalse(viewModel.showAlert, "showAlert should initially be false")
        
        // When
        viewModel.showAlert = true
        
        // Then
        XCTAssertTrue(viewModel.showAlert, "showAlert should be true after triggering alert presentation")
        
        // When (dismiss the alert)
        viewModel.showAlert = false
        
        // Then
        XCTAssertFalse(viewModel.showAlert, "showAlert should be false after dismissing alert")
    }

    func testBrowserPresentation() {
        // Given
        let viewModel = StockItemScene.StockItemViewModel(itemId: nil) // Initialize the view model
        XCTAssertFalse(viewModel.showBrowser, "showBrowser should initially be false")
        
        // When
        viewModel.showBrowser = true // Trigger the presentation of the browser
        
        // Then
        XCTAssertTrue(viewModel.showBrowser, "showBrowser should be true after triggering browser presentation")
        
        // When (dismiss the browser)
        viewModel.showBrowser = false // Dismiss the browser
        
        // Then
        XCTAssertFalse(viewModel.showBrowser, "showBrowser should be false after dismissing browser")
    }

}
