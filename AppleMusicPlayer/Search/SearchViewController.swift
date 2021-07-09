//
//  SearchViewController.swift
//  AppleMusicPlayer
//
//  Created by Damir Lutfullin on 24.03.2020.
//  Copyright (c) 2020 DamirLutfullin. All rights reserved.
//

import UIKit

protocol SearchDisplayLogic: AnyObject {
    func displayData(viewModel: Search.Model.ViewModel.ViewModelData)
}

class SearchViewController: UIViewController, SearchDisplayLogic {
    
    //MARK: properties
    var interactor: SearchBusinessLogic?
    var router: (NSObjectProtocol & SearchRoutingLogic)?
    private var timer: Timer?
    
    let searchController = UISearchController(searchResultsController: nil)
    
    private var searchViewModel = SearchViewModel(cells: [])
    private lazy var footer = FooterView()
    weak var tabBarDelegate: MainTabBarControllerDelegate?
    
    @IBOutlet var table: UITableView!
    
    
    // MARK: Setup
    private func setup() {
        let viewController        = self
        let interactor            = SearchInteractor()
        let presenter             = SearchPresenter()
        let router                = SearchRouter()
        viewController.interactor = interactor
        viewController.router     = router
        interactor.presenter      = presenter
        presenter.viewController  = viewController
        router.viewController     = viewController
    }
    
    // MARK: Routing
    
    
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
        searchController.obscuresBackgroundDuringPresentation = false
        setupSearchBar()
        setupTableView()
        searchBar(searchController.searchBar, textDidChange: "billie")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let keyWindow = UIApplication.shared.windows.first(where: {$0.isKeyWindow})?.rootViewController as? MainTabBarController
        keyWindow?.trackDetailView.delegateForTrackMoving = self
        
    }
    
    //MARK: display data
    func displayData(viewModel: Search.Model.ViewModel.ViewModelData) {
        switch viewModel {
        case .displayTraks (let searchViewModel):
            self.searchViewModel = searchViewModel
            self.table.reloadData()
            footer.stopLoader()
        case .displayFooterView:
            footer.showLoader()
        }
    }
    
   // MARK: Setup searchBar
    func setupSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
    }
    
    // MARK: Setup tableView
    func setupTableView() {
        let nib = UINib(nibName: "TrackCell", bundle: nil)
        table.register(nib, forCellReuseIdentifier: TrackCell.reuseId)
        table.tableFooterView = footer
    }
}

//MARK: - UITableViewDataSource, UITableViewDelegate

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchViewModel.cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = table.dequeueReusableCell(withIdentifier: TrackCell.reuseId, for: indexPath) as! TrackCell
        
        let cellViewModel = searchViewModel.cells[indexPath.row]
        cell.set(viewModel: cellViewModel)
        cell.imageView?.backgroundColor = .gray
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        84
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Please enter search term above"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return searchViewModel.cells.count > 0 ? 0 : 250
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cellViewModel = searchViewModel.cells[indexPath.row]
        
        self.tabBarDelegate?.maximaizeTrackDetailController(viewModel: cellViewModel)
    }
}

//MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.75, repeats: false, block: { [ weak self ]_ in
            self?.interactor?.makeRequest(request: Search.Model.Request.RequestType.getTracks(searchText: searchText))
        })
    }
}

// MARK: TrackMovingDelegate
extension SearchViewController: TrackMovingDelegate {
    
    private func getTrack(isForwardTrack: Bool) -> SearchViewModel.Cell? {
        guard let indexPath = table.indexPathForSelectedRow else { return nil }
        table.deselectRow(at: indexPath, animated: true)
        var nextIndexPath: IndexPath!
        if isForwardTrack {
            nextIndexPath = IndexPath(row: indexPath.row + 1, section: indexPath.section)
            if nextIndexPath.row == searchViewModel.cells.count {
                nextIndexPath.row = 0
            }
        } else {
            nextIndexPath = IndexPath(row: indexPath.row - 1, section: indexPath.section)
            if nextIndexPath.row == -1 {
                nextIndexPath.row = searchViewModel.cells.count - 1
            }
        }
        
        table.selectRow(at: nextIndexPath, animated: true, scrollPosition: .none)
        let cellViewModel = searchViewModel.cells[nextIndexPath.row]
        return cellViewModel
    }
    
    func moveToPreviosTrack() -> SearchViewModel.Cell? {
        print("go back")
        return getTrack(isForwardTrack: false)
    }
    
    func moveToNextTrack() -> SearchViewModel.Cell? {
        print("go forward")
        return getTrack(isForwardTrack: true)
    }
    
}

