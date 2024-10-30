//
//  TrendingResult.swift
//  COMMI
//
//  Created by Katerina Ivanova on 30.10.2023.
//

import Foundation

struct TrendingResult: Decodable {
    var movies: [TrendingMovie]
}
struct TrendingMovie: Decodable {
    var movie: MovieData?
}

struct MovieData: Decodable {
    let id, title, genre, image_url : String?
    let year, duration, releaseDate, description: String?
    let rating: Double?
}
