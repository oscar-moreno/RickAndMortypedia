//
//  RemoteImage.swift
//  RickAndMortypedia
//
//  Created by Óscar Moreno.
//

import Foundation
import SwiftUI
import Kingfisher

struct RemoteImage: View {
    let url: URL

    var body: some View {
        KFImage(url)
            .resizable()
    }
}
