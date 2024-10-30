//
//  HomeAssembly.swift
//  COMMI
//
//  Created by Katerina Dev on 21.09.24.
//

import Foundation

final class HomeAssembly {
    func makeModule() -> HomeViewController {
        let interactor = HomeInteractor()
        let view = HomeViewController()
        let router = HomeRouter(view)
        let presenter = HomePresenter(interactor: interactor, view: view, router: router)
        view.presenter = presenter
        return view
    }
}
