//
//  DependencyInjector.swift
//  RickAndMortypedia
//
//  Created by Óscar Moreno.
//

import Foundation

class DependencyInjector {
    private let networkService: NetworkService
    private let homeViewModel: HomeVM
    private let httpClient: HTTPClient

    init() {
        httpClient = URLSessionHTTPClient()
        networkService = RickAndMortyNetworkService(httpClient: httpClient)
        homeViewModel = HomeVM(networkService: networkService)
    }

    func buildHomeView() -> HomeView<FilterView> {
        HomeView(viewModel: homeViewModel, buildFilterView: buildFilterView)
    }

    private func buildFilterView() -> FilterView {
        FilterView(viewModel: FilterVM(parentViewModel: homeViewModel))
    }
}
