//
//  MainTabBarController.swift
//  AppleMusicPlayer
//
//  Created by Damir Lutfullin on 19.03.2020.
//  Copyright © 2020 DamirLutfullin. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    //MARK: Properties
    private var minimizedTopAnchorConstraint : NSLayoutConstraint!
    private var maximizedTopAchorConstraint : NSLayoutConstraint!
    private var bottomAncorConstraint: NSLayoutConstraint!
    
    let searchVC: SearchViewController = SearchViewController.loadFromStoryboard()
    let trackDetailView: TrackDetailView = TrackDetailView.loadViewNib()
    
    //MARK: Life cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTrackDetailView()
        searchVC.tabBarDelegate = self
        tabBar.tintColor = #colorLiteral(red: 1, green: 0, blue: 0.3764705882, alpha: 1)

        
        viewControllers = [
            createViewController(rootViewController: searchVC, image: #imageLiteral(resourceName: "search"), title: "Search"),
            createViewController(rootViewController: ViewController(), image:
                #imageLiteral(resourceName: "library"), title: "Library")
        ]
    }
    
    //MARK: Create view controllers
    private func createViewController(rootViewController: UIViewController, image: UIImage, title: String) -> UINavigationController {
        
        let navigationViewController = UINavigationController(rootViewController: rootViewController)
        navigationViewController.tabBarItem.image = image
        navigationViewController.tabBarItem.title = title
        rootViewController.navigationItem.title = title
        navigationViewController.navigationBar.prefersLargeTitles = true
        return navigationViewController
    }
    
    //MARK: Setup track detail view
    private func setupTrackDetailView() {
        trackDetailView.tabBarDelegate = self
        trackDetailView.delegateForTrackMoving = searchVC
        
        view.insertSubview(trackDetailView, belowSubview: tabBar)
        
        // use auto layout
        trackDetailView.translatesAutoresizingMaskIntoConstraints = false
        
        maximizedTopAchorConstraint = trackDetailView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height)
        minimizedTopAnchorConstraint = trackDetailView.topAnchor.constraint(equalTo: tabBar.topAnchor, constant: -64)
        bottomAncorConstraint = trackDetailView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: view.frame.height)
        
        maximizedTopAchorConstraint.isActive = true
        bottomAncorConstraint.isActive = true
        trackDetailView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        trackDetailView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}

//MARK: MainTabBarControllerDelegate

protocol MainTabBarControllerDelegate: class {
    func minimizedTrackDetailController()
    func maximaizeTrackDetailController(viewModel: SearchViewModel.Cell?)
}

extension MainTabBarController : MainTabBarControllerDelegate {
    
    func maximaizeTrackDetailController(viewModel: SearchViewModel.Cell?) {
        
        minimizedTopAnchorConstraint.isActive = false
        maximizedTopAchorConstraint.constant = 0
               bottomAncorConstraint.constant = 0
        maximizedTopAchorConstraint.isActive = true
        trackDetailView.mini = false
       
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut,
                       animations: {
                        self.view.layoutIfNeeded()
                        self.tabBar.alpha = 0
                        self.trackDetailView.miniPlayerStackView.alpha = 0
                        self.trackDetailView.bigPlayerStackView.alpha = 1
        },
                       completion: nil)
        
        guard let viewModel = viewModel else {
            return
        }
        
        self.trackDetailView.set(viewModel: viewModel)
    }
    
    
    func minimizedTrackDetailController() {
        
        maximizedTopAchorConstraint.isActive = false
        bottomAncorConstraint.constant = view.frame.height
        minimizedTopAnchorConstraint.isActive = true
        trackDetailView.mini = true
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut,
                       animations: {
                        self.view.layoutIfNeeded()
                        self.tabBar.alpha = 1
                        self.trackDetailView.bigPlayerStackView.alpha = 0
                        self.trackDetailView.miniPlayerStackView.alpha = 1
        },
                       completion: nil)
    }
}
