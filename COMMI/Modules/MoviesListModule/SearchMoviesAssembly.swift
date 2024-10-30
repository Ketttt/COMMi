//
//  SearchMoviesAssembly.swift
//  COMMI
//
//  Created by Katerina Dev on 24.10.24.
//

import Foundation

final class SearchMoviesAssembly {
    func makeModule() -> SearchMoviesController {
        let interactor = SearchMoviesInteractor()
        let view = SearchMoviesController()
        let presenter = SearchMoviesPresentor(interactor: interactor, view: view)
        view.presenter = presenter
        return view
    }
}
