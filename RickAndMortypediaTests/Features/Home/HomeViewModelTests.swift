//
//  HomeViewModelTests.swift
//  RickAndMortypediaTests
//
//  Created by Óscar Moreno.
//

import XCTest
@testable import RickAndMortypedia

final class HomeViewModelTests: XCTestCase {

    private var sut: HomeVM!
    private var networkServiceMock: NetworkService!
    private var expectation: XCTestExpectation!
    private let expectationDescription = "Fetch characters from GetDataNetworkMock"
    private var fakeInfo: Info!
    private var fakeResults: [Character]!
    private let numberOfFakePages = 2
    private let numberOfFakeCharacters = 40
    private let fakeNextPage = "https://nextApiPage.com"

    override func setUpWithError() throws {
        try super.setUpWithError()
        fakeInfo = Info(count: numberOfFakeCharacters, pages: numberOfFakePages, next: fakeNextPage, prev: nil)
        fakeResults = buildFakeResults(charactersNumber: numberOfFakeCharacters)
        networkServiceMock = RickAndMortyNetworkServiceMock(fakeResults: fakeResults, fakeInfo: fakeInfo)
        sut = HomeVM(networkService: networkServiceMock)
        expectation = expectation(description: expectationDescription)
    }

    func buildFakeResults(charactersNumber: Int) -> [Character] {
        var fakeResults = [Character]()
        for index in 1...charactersNumber {
            let location = Location(name: "Fake location \(index)")
            fakeResults.append(Character(id: index,
                                         name: "Fake name\(index)",
                                         status: "Fake status\(index)",
                                         species: "Fake specie\(index)",
                                         type: "Fake type\(index)",
                                         gender: "Fake gender\(index)",
                                         origin: location,
                                         location: location,
                                         imageUrl: "http://fakeurl\(index).com"))
        }
        return fakeResults
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testloadCharactersShouldFetchNextPageCharacters() async {
        // Arrange
        let currentPage = sut.currentPage

        // Act
        await sut.loadCharacters()
        expectation.fulfill()

        // Assert
        await waitForExpectations(timeout: 3.0)
        XCTAssertEqual(currentPage + 1, sut.currentPage)
        XCTAssertEqual(40, sut.characters.count)
    }

    func testFetchCharactersShouldSaveFetchedDataInViewModel() async {
        // Act
        await sut.fetchCharacters(with: NetworkParams(page: "1", name: nil, status: nil, gender: nil))
        expectation.fulfill()

        // Assert
        await waitForExpectations(timeout: 3.0)
        XCTAssertEqual(40, sut.queryInfo.count)
        XCTAssertEqual(2, sut.queryInfo.pages)
        XCTAssertEqual(40, sut.characters.count)
    }

    func testLoadMoreShouldLoadMoreWhenInfoNextParamExistAnd6IndexesMissing() async {
        // Arrange
        await sut.loadCharacters()
        expectation.fulfill()

        // Actual
        await waitForExpectations(timeout: 3.0)
        let actualResult = sut.mustLoadMoreCharacters(from: sut.characters[34])

        // Arrange
        XCTAssert(actualResult)
    }

    func testLoadMoreShouldNotLoadWhenInfoNextParamExistsButNot6IndexesMissing() async {
        // Arrange
        await sut.loadCharacters()
        expectation.fulfill()

        // Actual
        await waitForExpectations(timeout: 3.0)
        let actualResult = sut.mustLoadMoreCharacters(from: sut.characters[30])

        // Arrange
        XCTAssertFalse(actualResult)
    }

    func testLoadMoreShouldNotLoadWhenInfoNextParamDoesntExists() async {
        // Arrange
        fakeInfo = Info(count: numberOfFakeCharacters, pages: numberOfFakePages, next: nil, prev: nil)
        fakeResults = buildFakeResults(charactersNumber: numberOfFakeCharacters)
        networkServiceMock = RickAndMortyNetworkServiceMock(fakeResults: fakeResults, fakeInfo: fakeInfo)
        sut = HomeVM(networkService: networkServiceMock)
        await sut.loadCharacters()
        expectation.fulfill()

        // Actual
        await waitForExpectations(timeout: 3.0)
        let actualResult = sut.mustLoadMoreCharacters(from: sut.characters[34])

        // Arrange
        XCTAssertFalse(actualResult)
    }

    func testResetCharactersShouldEmptyCharactersArray() async {
        // Arrange
        await sut.loadCharacters()
        expectation.fulfill()

        // Actual
        sut.resetCharacters()
        await waitForExpectations(timeout: 3.0)

        // Arrange
        XCTAssertEqual(0, sut.currentPage)
        XCTAssertEqual(0, sut.characters.count)
    }

    func testResetQueryShouldResetFiltersSearchesAndCharacters() async {
        // Arrange
        sut.statusFilter = "alive"
        sut.genderFilter = "male"
        sut.characterSearchText = "Rick"
        await sut.loadCharacters()
        expectation.fulfill()

        // Actual
        sut.resetQueryValues()
        await waitForExpectations(timeout: 3.0)

        // Arrange
        XCTAssertEqual("", sut.statusFilter)
        XCTAssertEqual("", sut.genderFilter)
        XCTAssertEqual("", sut.characterSearchText)
        XCTAssertEqual(0, sut.currentPage)
        XCTAssertEqual(0, sut.characters.count)
    }

}
