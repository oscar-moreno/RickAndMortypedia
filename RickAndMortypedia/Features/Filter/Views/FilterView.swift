//
//  FilterView.swift
//  RickAndMortypedia
//
//  Created by Óscar Moreno.
//

import SwiftUI

struct FilterView: View {
    @ObservedObject var filterViewModel: FilterVM

    init(viewModel: FilterVM) {
        filterViewModel = viewModel
    }

    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    Text("status_title")
                        .padding()
                        .fontWeight(.semibold)
                    Picker("status_title", selection: $filterViewModel.selectedStatus) {
                        ForEach(Filter.Status.allCases ) { status in
                            Text(status.localizedString())
                        }
                    }
                    .pickerStyle(.segmented)
                }
                .padding()
                VStack {
                    Text("gender_title")
                        .padding()
                        .fontWeight(.semibold)
                    Picker("gender_title", selection: $filterViewModel.selectedGender) {
                        ForEach(Filter.Gender.allCases ) { gender in
                            Text(gender.localizedString())
                        }
                    }
                    .pickerStyle(.segmented)
                }
                .padding()
                Spacer()
                Button {
                    Task {
                        await filterViewModel.filterCharacters()
                    }
                } label: {
                    Text("filter_view_apply_filters")
                        .foregroundColor(.primary)
                        .colorInvert()
                }
                .padding()
                .background(.primary)
                .clipShape(Capsule())

            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        filterViewModel.hideSheet()
                    } label: {
                        Text("filter_view_cancel")
                            .foregroundColor(.primary)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        Task {
                            await filterViewModel.resetFilters()
                        }
                    } label: {
                        Text("filter_view_reset")
                            .foregroundColor(.primary)
                    }
                }
            }
        }
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView(
            viewModel: FilterVM(
                parentViewModel: HomeVM(
                    networkService: RickAndMortyNetworkService(
                        httpClient: URLSessionHTTPClient()))))
    }
}
