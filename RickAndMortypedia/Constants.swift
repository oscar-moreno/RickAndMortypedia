//
//  Constants.swift
//  RickAndMortypedia
//
//  Created by Óscar Moreno.
//

import Foundation

struct Constants {
    struct Images {
        static let placeholder = "ram-placeholder"
    }

    enum Filter: String {
        case inactive = "line.3.horizontal.decrease"
        case active = "line.3.horizontal.decrease.circle.fill"
    }

    enum Layout: String {
        case one = "rectangle.fill"
        case two = "rectangle.split.2x2.fill"
        case three = "rectangle.split.3x3.fill"
    }
}
