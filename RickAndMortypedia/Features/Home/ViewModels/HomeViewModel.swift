//
//  HomeViewModel.swift
//  RickAndMortypedia
//
//  Created by Óscar Moreno.
//

import Foundation
import SwiftUI

protocol HomeViewModel {
    var statusFilter: String { get set }
    var genderFilter: String { get set }
    var showFilter: Bool { get set }

    func resetCharacters()
    func resetQueryValues()
    func loadCharacters() async
}

class HomeVM: ObservableObject, HomeViewModel {
    @Published var characters = [Character]()
    @Published var queryInfo = Info(count: 0, pages: 0, next: nil, prev: nil)
    @Published var characterSearchText = String()
    @Published var showWarning = false
    @Published var showFilter = false
    @Published var layout = [GridItem(.flexible()), GridItem(.flexible())]

    let networkService: NetworkService
    var showWarningMessage = String()
    private var error: RequestError?

    var currentPage = 0
    internal var statusFilter = String()
    internal var genderFilter = String()

    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    func loadCharacters() async {
        currentPage += 1
        let params = NetworkParams(page: String(currentPage),
                              name: characterSearchText,
                              status: statusFilter,
                              gender: genderFilter)
        await fetchCharacters(with: params)
    }

    func fetchCharacters(with params: NetworkParams) async {
        do {
            let result = try await networkService.getCharacters(with: params)
            DispatchQueue.main.async {
                self.characters += result.results
                self.queryInfo = result.info
            }
        } catch {
            DispatchQueue.main.async {
                self.error = error as? RequestError
                if self.error != .notFound {
                    self.showWarningMessage =
                        RickAndMortyNetworkData.NetworErrorMessages.dataNotAvailable.localizedString()
                    self.showWarning = true
                }
            }
        }
    }

    func loadCharactersDebounced() {
        let debouncer = Debouncer(delay: 1.0) {
            Task {
                await self.loadCharacters()
            }
        }
        debouncer.call()
    }

    func mustLoadMoreCharacters(from character: Character) -> Bool {
        guard let index = characters.firstIndex(where: { $0.id == character.id })
        else { return false }

        return index + 6 == characters.count && queryInfo.next != nil
    }

    func resetCharacters() {
        currentPage = 0
        DispatchQueue.main.async {
            self.characters = [Character]()
        }
    }

    func resetQueryValues() {
        statusFilter = String()
        genderFilter = String()
        DispatchQueue.main.async {
            self.characterSearchText = String()
        }
        resetCharacters()
    }

    func nextLayout() {
        switch layout.count {
        case 1:
            layout = [GridItem(.flexible()), GridItem(.flexible())]
        case 2:
            layout = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
        case 3:
            layout = [GridItem(.flexible())]
        default:
            layout = [GridItem(.flexible()), GridItem(.flexible())]
        }
    }

    func getNextLayoutImage() -> String {
        switch layout.count {
        case 1:
            return Constants.Layout.one.rawValue
        case 2:
            return Constants.Layout.two.rawValue
        case 3:
            return Constants.Layout.three.rawValue
        default:
            return Constants.Layout.two.rawValue
        }
    }

    func getFilterImage() -> String {
        if statusFilter.isEmpty && genderFilter.isEmpty {
            return Constants.Filter.inactive.rawValue
        } else {
            return Constants.Filter.active.rawValue
        }
    }

}
