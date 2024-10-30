//
//  SearchResult.swift
//  COMMI
//
//  Created by Katerina Dev on 27.10.24.
//

import Foundation

// MARK: - SearchResult
struct SearchResult: Codable {
    var tv, movies, documentary, sports: [Movie]?
    init(){}
}

// MARK: - Movie
struct Movie: Codable {
    let item: MovieClass
}

// MARK: - MovieClass
struct MovieClass: Codable {
    let id, title: String
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case id, title
        case imageURL = "image_url"
    }
}

