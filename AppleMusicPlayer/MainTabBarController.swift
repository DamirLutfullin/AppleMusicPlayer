//
//  MainTabBarController.swift
//  AppleMusicPlayer
//
//  Created by Damir Lutfullin on 19.03.2020.
//  Copyright © 2020 DamirLutfullin. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [
            createViewController(rootViewController: SearchViewController(), image: #imageLiteral(resourceName: "search"), title: "Search"),
            createViewController(rootViewController: ViewController(), image:
                #imageLiteral(resourceName: "library"), title: "Library")
        ]
        
        tabBar.tintColor = #colorLiteral(red: 1, green: 0, blue: 0.3764705882, alpha: 1)
    }
    
    private func createViewController(rootViewController: UIViewController, image: UIImage, title: String) -> UINavigationController {
        
        let navigationViewController = UINavigationController(rootViewController: rootViewController)
        navigationViewController.tabBarItem.image = image
        navigationViewController.tabBarItem.title = title
        rootViewController.navigationItem.title = title
        navigationViewController.navigationBar.prefersLargeTitles = true
        return navigationViewController
    }
    
}
