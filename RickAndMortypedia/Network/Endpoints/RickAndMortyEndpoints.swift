//
//  RickAndMortyEndpoints.swift
//  RickAndMortypedia
//
//  Created by Óscar Moreno.
//

import Foundation

enum RickAndMortyEndpoints {
    case characters
}

extension RickAndMortyEndpoints: Endpoint {

    var header: [String: String]? {
        switch self {
        case .characters:
            return RickAndMortyNetworkData.header
        }
    }

    var path: String {
        switch self {
        case .characters:
            return RickAndMortyNetworkData.characterEndpoint
        }
    }

    var method: RequestMethod {
        switch self {
        case .characters:
            return .get
        }
    }

    var body: [String: String]? {
        switch self {
        case .characters:
            return nil
        }
    }

}
