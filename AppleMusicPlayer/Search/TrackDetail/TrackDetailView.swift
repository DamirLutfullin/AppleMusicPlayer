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

protocol TrackMovingDelegate {
    func moveToPreviosTrack() -> SearchViewModel.Cell?
    func moveToNextTrack() -> SearchViewModel.Cell?
}


class TrackDetailView: UIView {
    
    //MARK: IBOutlets
    // mini player
    @IBOutlet var progressView: UIProgressView!
    @IBOutlet var progress: UIProgressView!
    @IBOutlet var miniPlayerStackView: UIStackView!
    @IBOutlet var miniPlayerImageView: UIImageView!
    @IBOutlet var miniPlayerTrackName: UILabel!
    @IBOutlet var miniPlayerPlayPauseButton: UIButton!
    
    // big player
    
    @IBOutlet var bigPlayerStackView: UIStackView!
    @IBOutlet var trackImageView: UIImageView!
    @IBOutlet var currentTimeSlider: UISlider!
    @IBOutlet var currentTimeLabel: UILabel!
    @IBOutlet var durationLabel: UILabel!
    @IBOutlet var trackTitleLabel: UILabel!
    @IBOutlet var playPuseButton: UIButton!
    @IBOutlet var volumeSlider: UISlider!
    @IBOutlet var authorLabel: UILabel!
    
    
    // MARK: Property
    var mini: Bool = false
    
    let player: AVPlayer = {
        let player = AVPlayer()
        player.automaticallyWaitsToMinimizeStalling = false
        return player
    }()
    
    let scale: CGFloat = 0.8
    
    var delegateForTrackMoving: TrackMovingDelegate?
    weak var tabBarDelegate : MainTabBarControllerDelegate?
    
    // MARK: Life cicle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        trackImageView.transform = CGAffineTransform(scaleX: scale, y: scale)
        trackImageView.layer.cornerRadius = 15
        trackImageView.clipsToBounds = true
        
        setupGesture()
    }
    
    //MARK: IBActions
    @IBAction func dragDownButtomTapped(_ sender: UIButton) {
        // self.removeFromSuperview()
        self.tabBarDelegate?.minimizedTrackDetailController()
        miniPlayerStackView.isHidden = false
    }
    
    @IBAction func currentTimeSlider(_ sender: UISlider) {
        let precenrage = sender.value
        guard let duration = player.currentItem?.duration else { return }
        let seconds = CMTimeGetSeconds(duration)
        let searchSecond = Float64(precenrage) * seconds
        player.seek(to: CMTime(seconds: searchSecond, preferredTimescale: 1))
    }
    
    @IBAction func volumeSliderAction(_ sender: UISlider) {
        player.volume = sender.value
    }
    
    @IBAction func previosTrack(_ sender: UIButton) {
        let cellViewModel = delegateForTrackMoving?.moveToPreviosTrack()
        guard let cellInfo = cellViewModel else { return }
        self.set(viewModel: cellInfo)
    }
    
    @IBAction func nextTrack(_ sender: UIButton) {
        let cellViewModel = delegateForTrackMoving?.moveToNextTrack()
        guard let cellInfo = cellViewModel else { return }
        self.set(viewModel: cellInfo)
    }
    
    @IBAction func playPuseButtonPressed(_ sender: UIButton) {
        if player.timeControlStatus == .paused {
            player.play()
            playPuseButton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
            miniPlayerPlayPauseButton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
            increaseTrackImageView()
            
        } else {
            player.pause()
            playPuseButton.setImage(#imageLiteral(resourceName: "play"), for: .normal)
            miniPlayerPlayPauseButton.setImage(#imageLiteral(resourceName: "play"), for: .normal)
            reduseTrackImageView()
        }
    }
    
    // MARK: Set outlets
    func set(viewModel: SearchViewModel.Cell) {
        progressView.setProgress(0, animated: true)
        progress.setProgress(0, animated: true)
        trackTitleLabel.text = viewModel.trackName
        miniPlayerTrackName.text = viewModel.trackName
        authorLabel.text = viewModel.artistName
        monitorStartTime()
        observePlayerCurrentTime()
        let string600 = viewModel.iconUrlString?.replacingOccurrences(of: "100x100", with: "600x600") ?? ""
        trackImageView.sd_setImage(with: URL(string: string600), completed: nil)
        miniPlayerImageView.sd_setImage(with: URL(string: string600), completed: nil)
        playTrack(previewUrl: viewModel.previewUrl)
        playPuseButton.setImage(UIImage.init(systemName: "play.fill"), for: .normal)
        miniPlayerPlayPauseButton.setImage(UIImage.init(systemName: "play.fill"), for: .normal)
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
    
    //MARK: setup Gesture
    private func setupGesture() {
        miniPlayerStackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapToOpen)))
        miniPlayerStackView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(panGesture)))
        self.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(panGesture)))
    }
    
    @objc private func tapToOpen() {
       self.tabBarDelegate?.maximaizeTrackDetailController(viewModel: nil)
    }
    
    @objc private func panGesture(gesture: UIPanGestureRecognizer) {
        switch  gesture.state {
        case .changed:
            panCnanged(gesture: gesture)
        case .ended:
            panEnded(gesture: gesture)
        @unknown default:
            print(#function)
        }
    }
    
    private func panCnanged(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: superview)
        self.transform = CGAffineTransform(translationX: 0, y: translation.y)
        
        let newAlpha = (translation.y / (self.frame.height / 1.3)).magnitude
        if mini {
            self.miniPlayerStackView.alpha =  1 - newAlpha
            self.bigPlayerStackView.alpha =  newAlpha
            
        } else {
            self.miniPlayerStackView.alpha =  newAlpha
             self.bigPlayerStackView.alpha =  1 - newAlpha
        }
        
    }
    
    private func panEnded(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: superview)
        let velocity = gesture.velocity(in: superview)
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut,
                       animations: {
                        self.transform = .identity
                        if translation.y.magnitude > 200 || velocity.y.magnitude > 500 {
                            if self.mini {
                            self.tabBarDelegate?.maximaizeTrackDetailController(viewModel: nil)
                            } else {
                                self.tabBarDelegate?.minimizedTrackDetailController()
                            }
                        } else {
                            if !self.mini {
                            self.tabBarDelegate?.maximaizeTrackDetailController(viewModel: nil)
                            } else {
                                self.tabBarDelegate?.minimizedTrackDetailController()
                            }
                        }
        },
                       completion: nil)
    }
    
    
    
    //MARK: Animation
    private func increaseTrackImageView() {
        UIView.animate(withDuration: 1,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut,
                       animations: {
                        self.trackImageView.transform = .identity
                        self.miniPlayerImageView.transform = .identity
        },
                       completion: nil)
    }
    
    private func reduseTrackImageView() {
        UIView.animate(withDuration: 1,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut,
                       animations: {
                        self.trackImageView.transform = CGAffineTransform(scaleX: self.scale, y: self.scale)
                        self.miniPlayerImageView.transform = CGAffineTransform(scaleX: self.scale, y: self.scale)
        },
                       completion: nil)
    }
    
    //MARK: Time setup
    private func monitorStartTime() {
        let time = CMTimeMake(value: 1, timescale: 1000)
        let times = [NSValue(time: time)]
        player.addBoundaryTimeObserver(forTimes: times, queue: .main){ [weak self] in
            self?.increaseTrackImageView()
        }
    }
    
    private func observePlayerCurrentTime() {
        let interval = CMTime(value: 1, timescale: 2)
        player.addPeriodicTimeObserver(forInterval: interval, queue: .main) { [weak self] time in
            self?.currentTimeLabel.text = time.convertToString()
            
            guard let duration = self?.player.currentItem?.duration else { return }
            let timeLeft = duration - time
            self?.durationLabel.text = timeLeft.convertToString()
            self?.updateCurrentTimeSlider()
        }
    }
    
    func updateCurrentTimeSlider() {
        let currentTimeSeconds = CMTimeGetSeconds(player.currentTime())
        let durationSeconds = CMTimeGetSeconds(player.currentItem?.duration ?? player.currentTime())
        let value = currentTimeSeconds / durationSeconds
        self.currentTimeSlider.value = Float(value)
        self.progress.progress = Float(value)
        self.progressView.progress = Float(value)
    }
    
    
}
