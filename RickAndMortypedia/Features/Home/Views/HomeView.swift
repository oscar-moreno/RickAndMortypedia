//
//  HomeView.swift
//  RickAndMortypedia
//
//  Created by Óscar Moreno.
//

import SwiftUI

struct HomeView<FilterView: View>: View {

    @ObservedObject private var homeViewModel: HomeVM

    private let buildFilterView: () -> FilterView

    init(viewModel: HomeVM, buildFilterView: @escaping () -> FilterView) {
        self.homeViewModel = viewModel
        self.buildFilterView = buildFilterView
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: homeViewModel.layout) {
                    ForEach(homeViewModel.characters) { character in
                        NavigationLink {
                            CharacterView(character: character, parallaxVM: ParallaxVM())
                        } label: {
                            CharacterItemListView(character: character)
                        }
                        .task {
                            if homeViewModel.mustLoadMoreCharacters(from: character) {
                                await homeViewModel.loadCharacters()
                            }
                        }
                    }
                }
                .padding()
            }
            .refreshable {
                Task {
                    await homeViewModel.loadCharacters()
                }
            }
            .navigationTitle("home_view_title")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        homeViewModel.nextLayout()
                    } label: {
                        Image(systemName: homeViewModel.getNextLayoutImage())
                            .foregroundColor(.primary)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        homeViewModel.showFilter.toggle()
                    } label: {
                        Image(systemName: homeViewModel.getFilterImage())
                            .foregroundColor(.primary)
                    }
                    .sheet(isPresented: $homeViewModel.showFilter) {
                        buildFilterView()
                            .presentationDetents([.medium])
                    }
                }
            }
        }
        .alert(isPresented: $homeViewModel.showWarning, content: {
            let localizedString = NSLocalizedString("warning_title", comment: "").uppercased()
            return Alert(title: Text(localizedString), message: Text(homeViewModel.showWarningMessage))
        })
        .task {
            await homeViewModel.loadCharacters()
        }
        .searchable(text: $homeViewModel.characterSearchText, prompt: "search_prompt")
        .disableAutocorrection(true)
        .onChange(of: homeViewModel.characterSearchText) { newValue in
            homeViewModel.resetCharacters()
            homeViewModel.characterSearchText = newValue
            homeViewModel.loadCharactersDebounced()
        }
    }

}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(
            viewModel: HomeVM(
                networkService: RickAndMortyNetworkService(
                    httpClient: URLSessionHTTPClient()))) {
                        Text("Filter View")
                    }
    }
}
