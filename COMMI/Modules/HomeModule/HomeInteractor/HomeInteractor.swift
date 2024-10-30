//
//  HomeInteractor.swift
//  COMMI
//
//  Created by Katerina Dev on 21.09.24.
//

import Foundation


protocol IHomeInteractor {
    func fetchTrendingMovies() async -> TrendingResult?
}

final class HomeInteractor {
    init() {}
}

extension HomeInteractor: IHomeInteractor {
    
    func fetchTrendingMovies() async -> TrendingResult? {
        do {
            guard let path = Bundle.main.path(forResource: "HomeMovies", ofType: "json") else {
                print("Error: Unable to find HomeMovies.json file in the app bundle.")
                return nil
            }
            
            let url = URL(fileURLWithPath: path)
            let data = try Data(contentsOf: url, options: .mappedIfSafe)
            
            let decoder = JSONDecoder()
            let trendingResult = try decoder.decode(TrendingResult.self, from: data)
            
            return trendingResult
        } catch {
            print("Error: Failed to load or decode HomeMovies.json file: \(error.localizedDescription)")
            return nil
        }
    }
}
