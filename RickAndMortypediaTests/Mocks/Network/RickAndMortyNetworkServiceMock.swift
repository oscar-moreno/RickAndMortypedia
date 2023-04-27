//
//  RickAndMortyNetworkServiceMock.swift
//  RickAndMortypediaTests
//
//  Created by Óscar Moreno.
//

import Foundation
@testable import RickAndMortypedia

struct RickAndMortyNetworkServiceMock: NetworkService {
    var fakeInfo: Info
    var fakeResults = [Character]()
    let fakeCharacters: Characters

    init(fakeResults: [Character], fakeInfo: Info) {
        self.fakeResults = fakeResults
        self.fakeInfo = fakeInfo
        fakeCharacters = Characters(info: fakeInfo, results: fakeResults)
    }

    func getCharacters(with params: NetworkParams) async throws -> Characters {
        fakeCharacters
    }
}
