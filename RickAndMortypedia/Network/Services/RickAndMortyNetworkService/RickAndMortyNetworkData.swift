//
//  RickAndMortyNetworkData.swift
//  RickAndMortypedia
//
//  Created by Óscar Moreno.
//

import Foundation

struct RickAndMortyNetworkData {
    static let https = "https"
    static let apiHost = "rickandmortyapi.com/api/"
    static var characterEndpoint = "\(apiHost)character/"
    static let header = ["Content-Type": "application/json;charset=utf-8"]
    static let pageParam = "page"
    static let nameParam = "name"
    static let statusParam = "status"
    static let genderParam = "gender"

    enum NetworErrorMessages {
        case dataNotAvailable

        func localizedString() -> String {
            switch self {
            case .dataNotAvailable:
                return NSLocalizedString("data_not_available", comment: "")
            }
        }
    }
}
