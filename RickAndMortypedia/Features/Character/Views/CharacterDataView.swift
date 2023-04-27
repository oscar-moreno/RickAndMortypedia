//
//  CharacterDataView.swift
//  RickAndMortypedia
//
//  Created by Óscar Moreno.
//

import SwiftUI

struct CharacterDataView: View {
    let characterDataTitle: String
    let characterDataValue: String

    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Text("\(characterDataTitle):")
                .font(.headline)

            Text(characterDataValue.capitalizeFirst())
                .multilineTextAlignment(.leading)

        }
        .textInputAutocapitalization(.sentences)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(2)
    }
}

struct CharacterDataView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CharacterDataView(characterDataTitle: "Title", characterDataValue: "location value")
            CharacterDataView(characterDataTitle: "Title 2", characterDataValue: "location value 2")
        }
    }
}
