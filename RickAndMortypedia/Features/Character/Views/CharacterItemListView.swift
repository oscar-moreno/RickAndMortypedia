//
//  CharacterItemListView.swift
//  RickAndMortypedia
//
//  Created by Óscar Moreno.
//

import SwiftUI

struct CharacterItemListView: View {
    let character: Character

    var body: some View {
        VStack {
            if let imageUrl = URL(string: character.imageUrl) {
                RemoteImage(url: imageUrl)
                    .cornerRadius(20)
                    .scaledToFit()

            } else {
                Image("ram-placeholder")
                    .resizable()
                    .cornerRadius(20)
                    .scaledToFit()
            }
            Text(character.name)
                .font(.headline)
                .foregroundColor(.primary)
                .lineLimit(1)
        }
    }
}

struct CharacterItemListView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterItemListView(character: Character.exampleToPreview())
    }
}
