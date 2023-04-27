//
//  Character.swift
//  RickAndMortypedia
//
//  Created by Óscar Moreno.
//

import Foundation

struct Characters: Decodable {
    let info: Info
    var results: [Character]
}

struct Info: Decodable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

struct Character: Decodable, Identifiable {

    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: Location?
    let location: Location?
    let imageUrl: String

    enum CodingKeys: String, CodingKey {
        case id, name, status, species, type, gender, origin, location
        case imageUrl = "image"
    }

    static func exampleToPreview() -> Character {
        Character(id: 0,
                  name: "Character Name",
                  status: "Alive",
                  species: "CharacterSpecie",
                  type: "CharacterType",
                  gender: "Unknown",
                  origin: Location(name: "Earth"),
                  location: Location(name: "Earth"),
                  imageUrl: "")
    }
}
