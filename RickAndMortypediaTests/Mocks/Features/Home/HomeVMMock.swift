//
//  HomeVMMock.swift
//  RickAndMortypediaTests
//
//  Created by Óscar Moreno.
//

import Foundation
@testable import RickAndMortypedia

class HomeVMMock: HomeViewModel {
    var showFilter = false
    var statusFilter = String()
    var genderFilter = String()

    var resetCharactersCounter = 0
    var loadCharactersCounter = 0
    var resetQueryValuesCounter = 0

    func resetCharacters() {
        resetCharactersCounter += 1
    }

    func loadCharacters() async {
        loadCharactersCounter += 1
    }

    func resetQueryValues() {
        resetQueryValuesCounter += 1
    }
}
