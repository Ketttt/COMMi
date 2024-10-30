//
//  HomeRouter.swift
//  COMMI
//
//  Created by Katerina Dev on 21.09.24.
//

import UIKit

protocol IHomeRouter {
    func navigateToSecondModule(with id: String)
}

final class HomeRouter: IHomeRouter {

    var viewController: UIViewController?
    
    init(_ nav: UIViewController?) {
        self.viewController = nav
    }
    
    func navigateToSecondModule(with id: String) {
        guard let navigation = viewController?.navigationController else { return }
        let secondModule = MovieDetailAssembly().makeModule(with: id)
        navigation.pushViewController(secondModule, animated: true)
    }
}
