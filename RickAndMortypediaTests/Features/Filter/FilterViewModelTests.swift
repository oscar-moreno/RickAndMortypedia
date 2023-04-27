//
//  FilterViewModelTests.swift
//  RickAndMortypediaTests
//
//  Created by Óscar Moreno Zamora on 22/3/23.
//

import XCTest
@testable import RickAndMortypedia

final class FilterViewModelTests: XCTestCase {

    private var sut: FilterVM!
    private var parentViewModelMock: HomeVMMock!

    override func setUpWithError() throws {
        super.setUp()
        parentViewModelMock = HomeVMMock()
        sut = FilterVM(parentViewModel: parentViewModelMock)
    }

    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
    }

    func testFilterCharactersShouldLoadCharsWithFilters() async {
        // Arrange
        sut.selectedStatus = Filter.Status(rawValue: "alive")!
        sut.selectedGender = Filter.Gender(rawValue: "male")!

        // Act
        await sut.filterCharacters()

        // Arrange
        XCTAssertEqual(1, parentViewModelMock.resetCharactersCounter)
        XCTAssertEqual(1, parentViewModelMock.loadCharactersCounter)
        XCTAssertEqual("alive", parentViewModelMock.statusFilter)
        XCTAssertEqual("male", parentViewModelMock.genderFilter)
    }

    func testResetFiltersShouldResetStatusGenderAndCharacters() async {
        // Act
        await sut.resetFilters()

        // Arrange
        XCTAssertEqual(.none, sut.selectedStatus)
        XCTAssertEqual(.none, sut.selectedGender)
        XCTAssertEqual(1, parentViewModelMock.loadCharactersCounter)
        XCTAssertEqual(1, parentViewModelMock.resetQueryValuesCounter)
    }

}
