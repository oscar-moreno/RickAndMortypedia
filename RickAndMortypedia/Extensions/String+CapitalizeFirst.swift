//
//  String+FirstCapitalized.swift
//  RickAndMortypedia
//
//  Created by Óscar Moreno.
//

import Foundation

extension String {
    func capitalizeFirst() -> String {
        return prefix(1).capitalized + dropFirst()
    }
}
