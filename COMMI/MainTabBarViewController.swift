//
//  ViewController.swift
//  COMMI
//
//  Created by Katerina Ivanova on 18.10.2023.
//

import UIKit

final class MainTabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
        UITabBar.appearance().backgroundColor = .main
        tabBar.tintColor = .tabBarItemAccent
        tabBar.unselectedItemTintColor = .tabBarItemLight
    }
    
    private func generateTabBar() {
        let homeNav = UINavigationController(rootViewController: HomeAssembly().makeModule())
        let movieNav = UINavigationController(rootViewController: SearchMoviesAssembly().makeModule())
        
       viewControllers = [
        generateVC(viewController: homeNav, image: UIImage(systemName: "house.fill")),
        generateVC(viewController: movieNav, image: UIImage(systemName: "play.circle.fill"))
       ]
    }
    
    private func generateVC(viewController: UINavigationController, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.image = image
        return viewController
    }
}
