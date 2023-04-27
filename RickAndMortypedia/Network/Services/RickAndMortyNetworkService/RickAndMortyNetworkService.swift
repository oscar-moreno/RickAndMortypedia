//
//  RickAndMortyNetworkService.swift
//  RickAndMortypedia
//
//  Created by Óscar Moreno.
//

import Foundation

protocol NetworkService {
    func getCharacters(with params: NetworkParams) async throws -> Characters
}

struct NetworkParams {
    let page: String?
    let name: String?
    let status: String?
    let gender: String?
}

struct RickAndMortyNetworkService: NetworkService {

    private let httpClient: HTTPClient

    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }

    func getCharacters(with params: NetworkParams) async throws -> Characters {
        var charactersUrlComponents = buildUrlComponentsBase(endpoint: RickAndMortyEndpoints.characters)
        charactersUrlComponents.queryItems = [URLQueryItem]()

        var query = [String: String]()
        query[RickAndMortyNetworkData.pageParam] = params.page
        query[RickAndMortyNetworkData.nameParam] = params.name
        query[RickAndMortyNetworkData.statusParam] = params.status
        query[RickAndMortyNetworkData.genderParam] = params.gender

        query.forEach { key, value in
            let queryItem = URLQueryItem(name: key, value: value)
            charactersUrlComponents.queryItems?.append(queryItem)
        }

        guard let url = charactersUrlComponents.url else {
            throw RequestError.invalidURL
        }

        return try await httpClient.sendRequest(url: url)
    }

    private func buildUrlComponentsBase(endpoint: Endpoint) -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.transferProtocol
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path

        return urlComponents
    }
}
