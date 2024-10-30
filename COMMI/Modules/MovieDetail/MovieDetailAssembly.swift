//
//  MovieDetailAssembly.swift
//  COMMI
//
//  Created by Katerina Dev on 11.10.24.
//

import Foundation

final class MovieDetailAssembly {

    func makeModule(with id: String) -> MovieDetailViewController {
        let interactor = MovieDetailIterator()
        let view = MovieDetailViewController()
        let presenter = MovieDetailPresenter(
            itemId: id,
            view: view,
            interactor: interactor
        )
        view.presenter = presenter
        return view
    }
}
