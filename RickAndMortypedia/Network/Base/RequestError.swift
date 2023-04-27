//
//  RequestError.swift
//  RickAndMortypedia
//
//  Created by Óscar Moreno.
//

import Foundation

enum RequestError: Error {
    case decode
    case invalidURL
    case noResponse
    case unauthorized
    case notFound
    case unexpectedStatusCode
}
