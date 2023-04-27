//
//  ParallaxView.swift
//  RickAndMortypedia
//
//  Created by Óscar Moreno.
//

import SwiftUI

struct Parallax: ViewModifier {
    @ObservedObject var viewModel: ParallaxVM
    var magnitude: Double

    func body(content: Content) -> some View {
        content
            .offset(x: CGFloat(0), y: (viewModel.pitch * magnitude))
    }
}
