//
//  SearchViewController.swift
//  AppleMusicPlayer
//
//  Created by Damir Lutfullin on 20.03.2020.
//  Copyright © 2020 DamirLutfullin. All rights reserved.
//

import UIKit

class SearchViewController: UITableViewController {
    
    var searchBar = UISearchController(searchResultsController: nil)
    
    let tracks = [Track(track: "bad guy", artist: "Billie Eilish"), Track(track: "bury a friend", artist: "Billie Eilish")]

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
        cell.textLabel?.text = track.track + "\n" + track.artist
        return cell
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}
