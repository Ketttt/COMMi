//
//  SearchMoviesPresentor.swift
//  COMMI
//
//  Created by Katerina Ivanova on 28.10.2023.
//

import UIKit

protocol ISearchPresenter {
    func viewDidLoad()
}

final class SearchMoviesPresentor {
    
    var view: ISearchView
    var interactor: ISearchInteractor
    
    init(interactor: ISearchInteractor, view: ISearchView) {
        self.interactor = interactor
        self.view = view
    }
    
    private func fetchMovies() {
        Task {
            let movies = await interactor.fetchMovies()
            await view.updateView(movie: movies ?? SearchResult())
        }
    }
    
}

extension SearchMoviesPresentor: ISearchPresenter {
    func viewDidLoad() {
        fetchMovies()
    }
}
