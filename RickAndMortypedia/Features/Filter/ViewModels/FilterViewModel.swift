//
//  FilterViewModel.swift
//  RickAndMortypedia
//
//  Created by Óscar Moreno.
//

import Foundation

class FilterVM: ObservableObject {
    @Published var selectedStatus: Filter.Status
    @Published var selectedGender: Filter.Gender

    private var parentViewModel: HomeViewModel

    init(parentViewModel: HomeViewModel) {
        self.parentViewModel = parentViewModel
        selectedStatus = Filter.Status(rawValue: parentViewModel.statusFilter) ?? .none
        selectedGender = Filter.Gender(rawValue: parentViewModel.genderFilter) ?? .none
    }

    func filterCharacters() async {
        parentViewModel.resetCharacters()
        parentViewModel.statusFilter = selectedStatus.rawValue
        parentViewModel.genderFilter = selectedGender.rawValue
        await parentViewModel.loadCharacters()
        DispatchQueue.main.async {
            self.parentViewModel.showFilter.toggle()
        }
    }

    func resetFilters() async {
        DispatchQueue.main.async {
            self.selectedStatus = .none
            self.selectedGender = .none
        }
        parentViewModel.resetQueryValues()
        hideSheet()
        await parentViewModel.loadCharacters()
    }

    func hideSheet() {
        DispatchQueue.main.async {
            self.parentViewModel.showFilter.toggle()
        }
    }
}
