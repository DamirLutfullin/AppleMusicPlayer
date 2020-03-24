//
//  TrackCell.swift
//  AppleMusicPlayer
//
//  Created by Damir Lutfullin on 24.03.2020.
//  Copyright © 2020 DamirLutfullin. All rights reserved.
//

import Foundation

import UIKit

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
    
    static let reuseId = "trackCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func set(viewModel: TrackCellViewModel) {
        trackNameLabel.text = viewModel.trackName
        collectionNameLabel.text = viewModel.collectionName
        artisrNameLabel.text = viewModel.artistName
    }
    
}
