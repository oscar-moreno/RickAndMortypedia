//
//  RickAndMortypediaApp.swift
//  RickAndMortypedia
//
//  Created by Óscar Moreno Zamora on 17/3/23.
//

import SwiftUI

@main
struct RickAndMortypediaApp: App {
    private let dependencyInjector = DependencyInjector()
    var body: some Scene {
        WindowGroup {
            dependencyInjector.buildHomeView()
        }
    }
}
