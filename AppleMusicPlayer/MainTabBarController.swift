//
//  MainTabBarController.swift
//  AppleMusicPlayer
//
//  Created by Damir Lutfullin on 19.03.2020.
//  Copyright © 2020 DamirLutfullin. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    let searchVC: SearchViewController = SearchViewController.loadFromStoryboard()
    
    private var minimizedTopAnchorConstraint : NSLayoutConstraint!
    private var maximizedTopAchorConstraint : NSLayoutConstraint!
    private var bottomAncorConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchVC: SearchViewController = SearchViewController.loadFromStoryboard()
        
        setupTrackDetailView()
        
        viewControllers = [
            createViewController(rootViewController: searchVC, image: #imageLiteral(resourceName: "search"), title: "Search"),
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

    private func setupTrackDetailView() {
        let trackDetailView: TrackDetailView = TrackDetailView.loadViewNib()
        trackDetailView.backgroundColor = .gray
        trackDetailView.tabBarDelegate = self
        trackDetailView.delegate = self.searchVC
        
        view.insertSubview(trackDetailView, belowSubview: tabBar)
        
        // use auto layout
        trackDetailView.translatesAutoresizingMaskIntoConstraints = false
        
        maximizedTopAchorConstraint = trackDetailView.topAnchor.constraint(equalTo: view.topAnchor)
        minimizedTopAnchorConstraint = trackDetailView.topAnchor.constraint(equalTo: tabBar.topAnchor, constant: -64)
        bottomAncorConstraint = trackDetailView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: view.frame.height)
        
        maximizedTopAchorConstraint.isActive = true
        bottomAncorConstraint.isActive = true
        trackDetailView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        trackDetailView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}

extension MainTabBarController : MainTabBarControllerDelegate {
    
    func minimizedTrackDetailController() {
        
        
        maximizedTopAchorConstraint.isActive.toggle()
        minimizedTopAnchorConstraint.isActive.toggle()
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut,
                       animations: {
                        self.view.layoutIfNeeded()
        },
                       completion: nil)
    }
    
    
}
