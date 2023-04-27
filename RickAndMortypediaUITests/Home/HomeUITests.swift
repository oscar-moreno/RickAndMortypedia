//
//  HomeUITests.swift
//  RickAndMortypediaUITests
//
//  Created by Óscar Moreno.
//

import XCTest
@testable import RickAndMortypedia

final class HomeUITests: XCTestCase {
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

    func testMainElementsExists() throws {
        XCTAssert(app.navigationBars[Constants.Home.navigationBarTitle].exists)
        XCTAssert(app.navigationBars[Constants.Home.navigationBarTitle]
            .buttons[Constants.Home.emptyFilterSymbolText].exists)
        XCTAssert(app.navigationBars[Constants.Home.navigationBarTitle]
            .buttons[Constants.Home.rectangleTwoSymbolText].exists)
    }

    func testLayoutButtonShouldDisplayOneTwoOrThreeLayoutButton() {
        XCTAssert(
            app.navigationBars[Constants.Home.navigationBarTitle]
                .buttons[Constants.Home.rectangleTwoSymbolText]
                .exists
        )

        app.navigationBars[Constants.Home.navigationBarTitle]
            .buttons[Constants.Home.rectangleTwoSymbolText]
            .tap()

        XCTAssert(
            app.navigationBars[Constants.Home.navigationBarTitle]
                .buttons[Constants.Home.gridText]
                .exists
        )

        app.navigationBars[Constants.Home.navigationBarTitle]
            .buttons[Constants.Home.gridText]
            .tap()

        XCTAssert(
            app.navigationBars[Constants.Home.navigationBarTitle]
                .buttons[Constants.Home.rectangleText]
                .exists
        )

        app.navigationBars[Constants.Home.navigationBarTitle]
            .buttons[Constants.Home.rectangleText]
            .tap()

        XCTAssert(
            app.navigationBars[Constants.Home.navigationBarTitle]
                .buttons[Constants.Home.rectangleTwoSymbolText]
                .exists
        )
    }

    func testFilterButtonShouldToogleWhenAtLeastOneFilterIsActive() {
        app.navigationBars[Constants.Home.navigationBarTitle]
            .buttons[Constants.Home.emptyFilterSymbolText]
            .tap()
        app.buttons[Constants.Filter.aliveFilterText]
            .tap()
        app.buttons[Constants.Filter.applyFiltersText]
            .tap()

        XCTAssert(
            app.navigationBars[Constants.Home.navigationBarTitle]
                .buttons[Constants.Home.usedFilterSymbolText]
                .exists
        )

        app.navigationBars[Constants.Home.navigationBarTitle]
            .buttons[Constants.Home.usedFilterSymbolText]
            .tap()
        app.buttons[Constants.Filter.resetFilters]
            .tap()

        XCTAssert(
            app.navigationBars[Constants.Home.navigationBarTitle]
                .buttons[Constants.Home.emptyFilterSymbolText]
                .exists
        )

    }

}
