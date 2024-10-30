//
//  HomePresenter.swift
//  COMMI
//
//  Created by Katerina Dev on 21.09.24.
//

import Foundation

protocol IHomePresenter {
    func viewDidLoad()
    func showMovieDetail(with id: String)
}

final class HomePresenter {
    var interactor: IHomeInteractor
    var view: IHomeView
    var router: IHomeRouter

    init(interactor: IHomeInteractor, view: IHomeView, router: IHomeRouter) {
        self.interactor = interactor
        self.view = view
        self.router = router
    }
    
    private func fetchMovies() {
        Task {
            let movies = await interactor.fetchTrendingMovies()?.movies
            await view.updateView(movie: movies ?? [])
        }
    }
    
    func showMovieDetail(with id: String) {
        router.navigateToSecondModule(with: id)
    }
}

extension HomePresenter: IHomePresenter {
    func viewDidLoad() {
        fetchMovies()
    }
}
