//
//  MusicTableViewCell.swift
//  AppleMusicPlayer
//
//  Created by Damir Lutfullin on 24.03.2020.
//  Copyright © 2020 DamirLutfullin. All rights reserved.
//

import UIKit

class TrackTableViewCell: UITableViewCell {

    @IBOutlet var trackImage: UIImageView!
    @IBOutlet var songLabel: UILabel!
    @IBOutlet var albomName: UILabel!
    @IBOutlet var artisrName: UILabel!
    
    static let reuseId = "trackCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
