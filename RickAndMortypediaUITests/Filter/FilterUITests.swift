//
//  FilterUITests.swift
//  RickAndMortypediaUITests
//
//  Created by Óscar Moreno.
//

import XCTest

final class FilterUITests: XCTestCase {
    private var app: XCUIApplication!

    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func testFilterMainElementsExists() throws {

        app.navigationBars[Constants.Home.navigationBarTitle]
            .buttons[Constants.Home.emptyFilterSymbolText]
            .tap()

        XCTAssert(app.navigationBars[Constants.Filter.filterTitle].exists)
        XCTAssert(app.navigationBars[Constants.Filter.filterTitle]
            .buttons[Constants.Filter.cancelText].exists)
        XCTAssert(app.staticTexts[Constants.Filter.statusText].exists)
        XCTAssert(app.staticTexts[Constants.Filter.genderText].exists)
        XCTAssert(app.segmentedControls.buttons[Constants.Filter.noneText].exists)
        XCTAssert(app.segmentedControls.buttons[Constants.Filter.unknownText].exists)
        XCTAssert(app.segmentedControls.buttons[Constants.Filter.aliveFilterText].exists)
        XCTAssert(app.segmentedControls.buttons[Constants.Filter.deadFilterText].exists)
        XCTAssert(app.segmentedControls.buttons[Constants.Filter.maleFilterText].exists)
        XCTAssert(app.segmentedControls.buttons[Constants.Filter.femaleFilterText].exists)
    }

}
