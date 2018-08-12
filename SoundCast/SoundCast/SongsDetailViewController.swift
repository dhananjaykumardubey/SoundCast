//
//  SongsDetailViewController.swift
//  SoundCast
//
//  Created by Dhananjay Kumar Dubey on 09/08/18.
//  Copyright © 2018 Dhananjay Kumar Dubey. All rights reserved.
//

import UIKit
import Kingfisher

final class SongsDetailViewController: UIViewController {
    enum PlayMode {
        case none
        case loop
        case shuffle
    }
    private static let viewControllerIdentifier = "SongsDetailViewControllerIdentifier"
    
    lazy private var songsList: [SongItem] = []
    
    private let musicPlayer = MusicPlayer()
    private var mode = PlayMode.none
    
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
    
    @IBOutlet private weak var songImageView: UIImageView!
    @IBOutlet private weak var songName: UILabel!
    @IBOutlet private weak var startTimeLabel: UILabel!
    @IBOutlet private weak var endTimeLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
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
        self.musicPlayer.observer = { [unowned self] event in
            switch event {
            case .didBegin:
                print("didBegin")
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
            guard let songURL = self.currentSongItem.songLink else { return }
            print("Playing \(songURL)")
            self.musicPlayer.set(songURL: songURL, andPlayImmediatly: true)
        }
    }
    
    func handleDidEnd() {
        switch self.mode {
        case .loop:
            self.updateSong()
        case .shuffle:
            self.currentSongIndex = self.songsList.randomIndex(excluding: self.currentSongIndex)
        case .none:
            return
        }
    }
}

extension SongsDetailViewController {
    
    @IBAction func previousSong(_ sender: Any) {
        
        let previousIndex = self.currentSongIndex - 1
        self.currentSongIndex = previousIndex >= self.songsList.startIndex ? previousIndex : self.currentSongIndex
    }
    
    @IBAction func nextSong(_ sender: Any) {
        let nextIndex = self.currentSongIndex + 1
        self.currentSongIndex = nextIndex < self.songsList.endIndex ? nextIndex : self.currentSongIndex
    }
    
    
    @IBAction func playSong(_ sender: Any) {
        self.updateSong()
    }

    @IBAction func repeatSong(_ sender: Any) {
        self.mode = self.mode == .loop ? .none : .loop
    }
    
    @IBAction func shuffleSong(_ sender: Any) {
        self.mode = self.mode == .shuffle ? .none : .shuffle
    }
    
}
