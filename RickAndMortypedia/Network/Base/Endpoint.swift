//
//  Endpoint.swift
//  RickAndMortypedia
//
//  Created by Óscar Moreno.
//

import Foundation

protocol Endpoint {
    var transferProtocol: String { get }
    var host: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var header: [String: String]? { get }
}

extension Endpoint {
    var transferProtocol: String {
        return RickAndMortyNetworkData.https
    }

    var host: String {
        return RickAndMortyNetworkData.apiHost
    }
}
