//
//  SearchViewController.swift
//  AppleMusicPlayer
//
//  Created by Damir Lutfullin on 20.03.2020.
//  Copyright © 2020 DamirLutfullin. All rights reserved.
//

import UIKit
import Alamofire

class SearchViewController: UITableViewController {
    
    var timer: Timer?
    
    var networkManager = NetService()
    
    var searchBar = UISearchController(searchResultsController: nil)
    
    var tracks: [Result] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        setupSearchBar()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    func setupSearchBar() {
        navigationItem.searchController = searchBar
        navigationItem.searchController?.searchBar.delegate = self
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let track = tracks[indexPath.row]
        cell.imageView?.image = #imageLiteral(resourceName: "Image")
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = (track.trackName) + "\n" + (track.artistName)
        return cell
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
            let url = "https://itunes.apple.com/search?"
            let parameters = ["term" : searchText,
                              "limit" : "10",
                              "media" : "music"]
            NetworkService.getResponse(url: url, parameters: parameters) {[weak self] (result) in
                self?.tracks = result ?? []
                self?.tableView.reloadData()
            }
        })
    }
}

