//
//  MovieDetailPresenter.swift
//  COMMI
//
//  Created by Katerina Dev on 11.10.24.
//

import Foundation

protocol MovieDetailPresenterInput {
    func viewDidLoad()
}

final class MovieDetailPresenter {
    
    var view: IMovieDetailView
    var interactor: IMovieDetailIterator
    var itemId: String?
    
    init(itemId: String,
         view: IMovieDetailView,
         interactor: IMovieDetailIterator) {
        self.itemId = itemId
        self.view = view
        self.interactor = interactor
    }
    
    private func fetchRelatedMovies() {
        Task {
            let movies = await interactor.fetchRelatedMovies()?.movies
            await view.relatedMovies(movies: movies ?? [])
        }
    }
    
    private func fetchMovieDetail() {
        Task {
            if let movie = await interactor.fetchdMovies()?.movies.first(where: {$0.movie?.id == itemId }) {
                await view.movieDetail(movie: movie)
            }
        }
    }
    
}

//MARK: - MovieDetailPresenterInput
extension MovieDetailPresenter: MovieDetailPresenterInput {
    func viewDidLoad() {
        fetchRelatedMovies()
        fetchMovieDetail()
    }
}
