//
//  SearchMoviesInteractor.swift
//  COMMI
//
//  Created by Katerina Ivanova on 28.10.2023.
//

import Foundation

protocol ISearchInteractor {
    func fetchMovies() async -> SearchResult?
}

final class SearchMoviesInteractor {
    
    init() {}
    
}


extension SearchMoviesInteractor: ISearchInteractor {
    func fetchMovies() async -> SearchResult? {
        do {
            guard let path = Bundle.main.path(forResource: "SearchMovies", ofType: "json") else {
                print("Error: Unable to find SearchMovies.json file in the app bundle.")
                return nil
            }
            let url = URL(fileURLWithPath: path)
            let data = try Data(contentsOf: url, options: .mappedIfSafe)
            
            let decoder = JSONDecoder()
            let searchResult = try decoder.decode(SearchResult.self, from: data)
            return searchResult
        } catch {
            print("Error: Failed to load or decode SearchMovies.json file: \(error.localizedDescription)")
            return nil
        }
    }
}
