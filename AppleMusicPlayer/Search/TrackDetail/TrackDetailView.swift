//
//  TrackDetailView.swift
//  AppleMusicPlayer
//
//  Created by Damir Lutfullin on 27.03.2020.
//  Copyright © 2020 DamirLutfullin. All rights reserved.
//

import UIKit
import SDWebImage
import AVKit

class TrackDetailView: UIView {

    //MARK: IBOutlets
    @IBOutlet var trackImageView: UIImageView!
    @IBOutlet var currentTimeSlider: UISlider!
    @IBOutlet var currentTimeLabel: UILabel!
    @IBOutlet var durationLabel: UILabel!
    @IBOutlet var trackTitleLabel: UILabel!
    @IBOutlet var playPuseButton: UIButton!
    @IBOutlet var volumeSlider: UISlider!
    @IBOutlet var authorLabel: UILabel!
    
    
    // MARK: Property
    let player: AVPlayer = {
        let player = AVPlayer()
        player.automaticallyWaitsToMinimizeStalling = false
        return player
    }()
    
    // MARK: Life cicle
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    //MARK: IBActions
    @IBAction func dragDownButtomTapped(_ sender: UIButton) {
        self.removeFromSuperview()
    }
    
    @IBAction func currentTimeSlider(_ sender: UISlider) {
    }
    
    @IBAction func volumeSliderAction(_ sender: UISlider) {
    }
    
    @IBAction func previosTrack(_ sender: UIButton) {
    }
    
    @IBAction func nextTrack(_ sender: UIButton) {
    }
    
    @IBAction func playPuseButtonPressed(_ sender: UIButton) {
        if player.timeControlStatus == .paused {
            player.play()
            playPuseButton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
        } else {
            player.pause()
            playPuseButton.setImage(#imageLiteral(resourceName: "play"), for: .normal)
        }
    }
    
    // MARK: Set outlets
    func set(viewModel: SearchViewModel.Cell) {
        trackTitleLabel.text = viewModel.trackName
        authorLabel.text = viewModel.artistName
        
        let string600 = viewModel.iconUrlString?.replacingOccurrences(of: "100x100", with: "600x600") ?? ""
        trackImageView.sd_setImage(with: URL(string: string600), completed: nil)
        playTrack(previewUrl: viewModel.previewUrl)
        
    }
    
    private func playTrack(previewUrl: String?) {
        guard let url = URL(string: previewUrl ?? "") else {
            return
        }
        let playerItem = AVPlayerItem(url: url)
        player.replaceCurrentItem(with: playerItem)
        player.play()
    }
    
    
    
}
