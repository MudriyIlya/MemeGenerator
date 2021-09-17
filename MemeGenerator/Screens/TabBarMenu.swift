//
//  TabBarMenu.swift
//  MemeGenerator
//
//  Created by Илья Мудрый on 17.09.2021.
//

import UIKit

class TabBarMenu: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.Palette.backgroundColor
        UITabBar.appearance().barTintColor = UIColor.Palette.backgroundColor
        tabBar.tintColor = UIColor.Palette.tint
        
        setupVC()
    }
    
    func setupVC() {
        guard let libraryImage = UIImage(systemName: "folder") else { return }
        guard let topMemesImage = UIImage(systemName: "guitars") else { return }
        viewControllers = [
            // TODO: убрать ! force-unwrap
            createNavigationController(with: LibraryViewController(), title: "Мемасики", image: libraryImage),
            createNavigationController(with: TopMemesViewController(), title: "Шаблоны", image: topMemesImage)
        ]
    }
    
    func createNavigationController(with rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = image
        rootViewController.title = title
        return navigationController
    }
    
}
