//
//  MovieDetailIterator.swift
//  COMMI
//
//  Created by Katerina Dev on 11.10.24.
//

import Foundation

protocol IMovieDetailIterator {
    func fetchRelatedMovies() async -> TrendingResult?
    func fetchdMovies() async -> TrendingResult?
}

final class MovieDetailIterator {
    init() {}
}

extension MovieDetailIterator: IMovieDetailIterator {
    func fetchRelatedMovies() async -> TrendingResult? {
        do {
            guard let path = Bundle.main.path(forResource: "MovieDetail", ofType: "json") else {
                print("Error: Unable to find MovieDetail.json file in the app bundle.")
                return nil
            }
            
            let url = URL(fileURLWithPath: path)
            let data = try Data(contentsOf: url, options: .mappedIfSafe)
            
            let decoder = JSONDecoder()
            let trendingResult = try decoder.decode(TrendingResult.self, from: data)
            
            return trendingResult
        } catch {
            print("Error: Failed to load or decode MovieDetail.json file: \(error.localizedDescription)")
            return nil
        }
    }
    
    func fetchdMovies() async -> TrendingResult? {
        do {
            guard let path = Bundle.main.path(forResource: "HomeMovies", ofType: "json") else {
                print("Error: Unable to find MovieDetail.json file in the app bundle.")
                return nil
            }
            
            let url = URL(fileURLWithPath: path)
            let data = try Data(contentsOf: url, options: .mappedIfSafe)
            
            let decoder = JSONDecoder()
            let trendingResult = try decoder.decode(TrendingResult.self, from: data)
            
            return trendingResult
        } catch {
            print("Error: Failed to load or decode MovieDetail.json file: \(error.localizedDescription)")
            return nil
        }
    }
}
