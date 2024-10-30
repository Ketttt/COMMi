//
//  MenuTitles.swift
//  COMMI
//
//  Created by Katerina Dev on 28.10.24.
//

import Foundation

enum MenuTitles: String, CaseIterable {
    case movies = "Movies"
    case tvSeries = "Tv Series"
    case documentary = "Documentary"
    case sports = "Sports"

    static var titles: [String] {
        return MenuTitles.allCases.map { $0.rawValue }
    }
}
