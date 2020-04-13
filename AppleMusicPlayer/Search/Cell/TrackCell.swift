//
//  TrackCell.swift
//  AppleMusicPlayer
//
//  Created by Damir Lutfullin on 24.03.2020.
//  Copyright © 2020 DamirLutfullin. All rights reserved.
//

import Foundation

import UIKit
import SDWebImage

protocol TrackCellViewModel {
    var iconUrlString: String? {get}
    var trackName: String {get}
    var artistName: String {get}
    var collectionName: String? {get}
}

class TrackCell: UITableViewCell {
    
    @IBOutlet var trackIcon: UIImageView!
    @IBOutlet var trackNameLabel: UILabel!
    @IBOutlet var collectionNameLabel: UILabel!
    @IBOutlet var artisrNameLabel: UILabel!
    @IBOutlet var addButton: UIButton!
    
    
    static let reuseId = "trackCell"
    let defaults = UserDefaults.standard

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        trackIcon.image = nil
    }
    
    var cell: SearchViewModel.Cell?
    
    func set(viewModel: SearchViewModel.Cell) {
        cell = viewModel
        
        let hasFavorite = TraksStore.tracksForList.first(where: {
            $0.trackName == self.cell?.trackName &&
                $0.collectionName == self.cell?.collectionName
        }) != nil
        if hasFavorite {
            addButton.isEnabled = false
        } else {
            addButton.isEnabled = true
        }
        trackNameLabel.text = viewModel.trackName
        collectionNameLabel.text = viewModel.collectionName
        artisrNameLabel.text = viewModel.artistName
        
        guard let url = URL(string: viewModel.iconUrlString ?? "") else { return }
        trackIcon.sd_setImage(with: url, completed: nil)
    }
    
    @IBAction func saveTrack(_ sender: UIButton) {
        addButton.isEnabled = false
        guard let cell = cell else { return }
        TraksStore.tracksForList.append(cell)
//        if let saveData = try? NSKeyedArchiver.archivedData(withRootObject: TraksStore.tracksForList, requiringSecureCoding: false) {
//            print("успешно!")
//            defaults.set(saveData, forKey: "traks")
//        }
        for tracks in TraksStore.tracksForList {
            print(tracks.trackName)
        }
    }
    
}



