//
//  SongsDetailViewController.swift
//  SoundCast
//
//  Created by Dhananjay Kumar Dubey on 09/08/18.
//  Copyright © 2018 Dhananjay Kumar Dubey. All rights reserved.
//

import UIKit
import Kingfisher

/// This class used to display each song played. Along with other functionality like play, pause, stop, repeat, shuffle. This class also handles automatic play of next song if present.
final class SongsDetailViewController: UIViewController {
    // MARK: Private enum
   private enum PlayMode {
        case none
        case loop
        case shuffle
    }
    // MARK: private constants
    private static let viewControllerIdentifier = "SongsDetailViewControllerIdentifier"
    lazy private var songsList: [SongItem] = []
    private let musicPlayer = MusicPlayer()
    private var mode = PlayMode.none
    
    // MARK: private computed properties
    private var _currentSongIndex: Int = 0 {
        didSet {
            self.musicPlayer.stop()
            self.updateSong()
            self.configureUI()
        }
    }
    
    private var currentSongIndex: Int {
        get {
            return self._currentSongIndex
        }
        set {
            if self._currentSongIndex != newValue {
                self._currentSongIndex = newValue
            }
        }
    }
    
    private var currentSongItem: SongItem {
        return self.songsList[self.currentSongIndex]
    }
    
    //MARK: Private outlets
    
    @IBOutlet private weak var playButton: UIButton!
    
    @IBOutlet private weak var repeatButton: UIButton!
    
    @IBOutlet private weak var shuffleButton: UIButton!
    
    @IBOutlet private weak var songImageView: UIImageView!
    
    @IBOutlet private weak var songName: UILabel!
    
    @IBOutlet private weak var startTimeLabel: UILabel! {
        didSet {
            self.startTimeLabel.layer.masksToBounds = true
            self.startTimeLabel.layer.cornerRadius = 5.0
        }
    }
    
    @IBOutlet private weak var endTimeLabel: UILabel! {
        didSet {
            self.endTimeLabel.layer.masksToBounds = true
            self.endTimeLabel.layer.cornerRadius = 5.0
        }
    }
    
    @IBOutlet private weak var contentView: UIView! {
        didSet {
            guard let image = UIImage(named: MusicResource.detailsBackgroundImage) else {
                return
            }
            self.contentView.backgroundColor = UIColor(patternImage: image)
        }
    }
    
    @IBOutlet private weak var playPauseView: UIView! {
        didSet {
            self.playPauseView.layer.cornerRadius = 15.0
        }
    }
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    // MARK: Functions
    
    /**
     Instantiate song details view controller with all the songs and also the current index
     
     - parameters:
        - songsList: provides lists of songs Item - `[SongItem]`
        - index: current song index played
     - returns: Instance of `SongsDetailViewController`
     */
    static func instantiateSongsDetail(withSongsList songsList: [SongItem], forIndex index: Int) -> SongsDetailViewController {
        let storyboard = Storyboard.main.instance
        
        guard let songDetailVC = storyboard.instantiateViewController(withIdentifier: self.viewControllerIdentifier) as? SongsDetailViewController else {
            return SongsDetailViewController()
        }
        songDetailVC.songsList = songsList
        songDetailVC._currentSongIndex = index
        
        return songDetailVC
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
        self.playButton?.setImage(UIImage.init(named: MusicResource.pauseIcon), for: .normal)
        self.musicPlayer.observer = { [unowned self] event in
            switch event {
            case .didBegin:
                self.progressBar.setProgress(0.0, animated: false)
            case .didEnd:
                self.handleDidEnd()
            case .progress(let progress):
                self.endTimeLabel.text = String(format: "%0.2f", progress.duration)
                self.startTimeLabel.text = String(format: "%0.2f", progress.currentTime)
                self.progressBar.setProgress(Float(progress.percentCompleted), animated: true)
            }
        }
    }
    
    private func configureUI() {
        
        self.songName?.text = self.currentSongItem.songTitle
        guard let imageURL = self.currentSongItem.songThumbnailLink else { return }
        self.songImageView?.kf.setImage(with: imageURL)
    }
    
    
    private func updateSong() {
        switch self.musicPlayer.state {
        case .playing:
            self.musicPlayer.pause()
        case .paused:
            self.musicPlayer.play()
        case .stopped:
            self.playButton?.setImage(UIImage(named: MusicResource.pauseIcon), for: .normal)
            guard let songURL = self.currentSongItem.songLink else { return }
            self.musicPlayer.set(songURL: songURL, andPlayImmediatly: true)
        }
    }
    
    private func handleDidEnd() {
        self.playButton?.setImage(UIImage(named: MusicResource.playIcon), for: .normal)
        switch self.mode {
        case .loop:
            self.updateSong()
        case .shuffle:
            self.currentSongIndex = self.songsList.randomIndex()
        case .none:
            self.playNextSong(didEnd: true)
        }
    }
    
    private func playNextSong(didEnd: Bool) {
        self.playButton?.setImage(UIImage(named: MusicResource.pauseIcon), for: .normal)
        let nextIndex = self.currentSongIndex + 1
        if nextIndex < self.songsList.endIndex {
            self.currentSongIndex = nextIndex
        } else if didEnd {
           self.playButton?.setImage(UIImage(named: MusicResource.playIcon), for: .normal)
        }
    }
    
    private func handlePlayButtonImage() {
        let image = self.musicPlayer.state == .playing ? UIImage(named: MusicResource.playIcon) : UIImage(named: MusicResource.pauseIcon)
        self.playButton?.setImage(image, for: .normal)
    }
}

// MARK: Actions
extension SongsDetailViewController {
    
    @IBAction private func previousSong(_ sender: Any) {
        self.playButton?.setImage(UIImage(named: MusicResource.pauseIcon), for: .normal)
        let previousIndex = self.currentSongIndex - 1
        self.currentSongIndex = previousIndex >= self.songsList.startIndex ? previousIndex : self.currentSongIndex
    }
    
    @IBAction private func nextSong(_ sender: Any) {
        self.playNextSong(didEnd: false)
    }
    
    
    @IBAction func playSong(_ sender: Any) {
        
       self.handlePlayButtonImage()
        self.updateSong()
    }
    
    @IBAction func repeatSong(_ sender: Any) {
        self.mode = self.mode == .loop ? .none : .loop
        self.repeatButton.alpha = self.mode == .loop ? 0.5 : 1.0
        
    }
    
    @IBAction func shuffleSong(_ sender: Any) {
        self.mode = self.mode == .shuffle ? .none : .shuffle
        self.shuffleButton.alpha = self.mode == .shuffle ? 0.5 : 1.0
    }
    
    @IBAction func stopSong(_ sender: Any) {
        self.playButton?.setImage(UIImage(named: MusicResource.playIcon), for: .normal)
        self.musicPlayer.stop()
    }
    
}
