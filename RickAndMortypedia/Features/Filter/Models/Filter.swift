//
//  Filter.swift
//  RickAndMortypedia
//
//  Created by Óscar Moreno.
//

import Foundation

struct Filter {
    enum Status: String, CaseIterable, Identifiable {

        var id: Self { self }

        case none = ""
        case alive
        case dead
        case unknown

        func localizedString() -> String {
            switch self {
            case .none:
                return NSLocalizedString("filter_view_none", comment: "")
            case .alive:
                return NSLocalizedString("filter_view_status_alive", comment: "")
            case .dead:
                return NSLocalizedString("filter_view_status_dead", comment: "")
            case .unknown:
                return NSLocalizedString("filter_view_unknown", comment: "")
            }
        }

    }

    enum Gender: String, CaseIterable, Identifiable {

        var id: Self { self }

        case none = ""
        case male
        case female
        case unknown

        func localizedString() -> String {
            switch self {
            case .none:
                return NSLocalizedString("filter_view_none", comment: "")
            case .male:
                return NSLocalizedString("filter_view_gender_male", comment: "")
            case .female:
                return NSLocalizedString("filter_view_gender_female", comment: "")
            case .unknown:
                return NSLocalizedString("filter_view_unknown", comment: "")
            }
        }

    }
}
