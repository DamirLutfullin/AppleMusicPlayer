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

        view.backgroundColor = .gray
        
        let searchViewControler = SearchViewController()
        let navigationViewController = UINavigationController(rootViewController: searchViewControler)
        let libraryViewController = ViewController()
        
        viewControllers = [
            navigationViewController,
            libraryViewController
        ]
    }
    
}
