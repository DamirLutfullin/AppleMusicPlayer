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
    
    let scale: CGFloat = 0.8
    
    // MARK: Life cicle
    override func awakeFromNib() {
        super.awakeFromNib()

        trackImageView.transform = CGAffineTransform(scaleX: scale, y: scale)
        trackImageView.layer.cornerRadius = 15
        trackImageView.clipsToBounds = true
        
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
            increaseTrackImageView()
            
        } else {
            player.pause()
            playPuseButton.setImage(#imageLiteral(resourceName: "play"), for: .normal)
            reduseTrackImageView()
        }
    }
    
    // MARK: Set outlets
    func set(viewModel: SearchViewModel.Cell) {
        trackTitleLabel.text = viewModel.trackName
        authorLabel.text = viewModel.artistName
        monitorStartTime()
        let string600 = viewModel.iconUrlString?.replacingOccurrences(of: "100x100", with: "600x600") ?? ""
        trackImageView.sd_setImage(with: URL(string: string600), completed: nil)
        playTrack(previewUrl: viewModel.previewUrl)
        
    }
    
    //MARK: music player
    private func playTrack(previewUrl: String?) {
        guard let url = URL(string: previewUrl ?? "") else {
            return
        }
        let playerItem = AVPlayerItem(url: url)
        player.replaceCurrentItem(with: playerItem)
        player.play()
    }
    
    //MARK: Animation
    private func increaseTrackImageView() {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.trackImageView.transform = .identity
        }, completion: nil)
    }
    
    private func reduseTrackImageView() {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.trackImageView.transform = CGAffineTransform(scaleX: self.scale, y: self.scale)
        }, completion: nil)
    }
    
    
    private func monitorStartTime() {
        let time = CMTimeMake(value: 1, timescale: 3)
        let times = [NSValue(time: time)]
        player.addBoundaryTimeObserver(forTimes: times, queue: .main){ [weak self] in
            self?.increaseTrackImageView()
        }
    }
    
    
}
