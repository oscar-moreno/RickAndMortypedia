//
//  CharacterView.swift
//  RickAndMortypedia
//
//  Created by Óscar Moreno.
//

import SwiftUI

struct CharacterView: View {
    let character: Character
    @ObservedObject var parallaxVM: ParallaxVM

    var body: some View {
        ScrollView {
            VStack {
                if let imageUrl = URL(string: character.imageUrl) {
                    RemoteImage(url: imageUrl)
                        .cornerRadius(20)
                        .scaledToFit()
                        .padding()
                } else {
                    Image("ram-placeholder")
                        .cornerRadius(20)
                        .padding()
                }

                Text(character.name)
                    .font(.title)
                    .bold()
                    .padding(10)

                VStack(alignment: .leading, spacing: 2) {
                    CharacterDataView(characterDataTitle: NSLocalizedString("status_title",
                                                                            comment: ""),
                                      characterDataValue: character.status)
                    CharacterDataView(characterDataTitle: NSLocalizedString("species_title",
                                                                            comment: ""),
                                      characterDataValue: character.species)
                    CharacterDataView(characterDataTitle: NSLocalizedString("gender_title",
                                                                            comment: ""),
                                      characterDataValue: character.gender)
                    CharacterDataView(characterDataTitle: NSLocalizedString("origin_title",
                                                                            comment: ""),
                                      characterDataValue: character.origin?.name ??
                                      "location_unknown")
                    CharacterDataView(characterDataTitle: NSLocalizedString("last_location_title",
                                                                            comment: ""),
                                      characterDataValue: character.location?.name ??
                                      "location_unknown")
                }
                .padding()

                Spacer()

            }
            .padding()
            .modifier(Parallax(viewModel: parallaxVM, magnitude: 30))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct CharacterView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterView(character: Character.exampleToPreview(), parallaxVM: ParallaxVM())
    }
}
