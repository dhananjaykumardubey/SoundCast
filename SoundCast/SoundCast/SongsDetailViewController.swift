//
//  SongsDetailViewController.swift
//  SoundCast
//
//  Created by Dhananjay Kumar Dubey on 09/08/18.
//  Copyright © 2018 Dhananjay Kumar Dubey. All rights reserved.
//

import Foundation
import UIKit

final class SongsDetailViewController: UIViewController {
    private static let viewControllerIdentifier = "SongsDetailViewControllerIdentifier"
    
    private var songItem: SongItem?
    lazy private var songsList: [SongItem] = []
    private var musicPlayer: MusicPlayer?
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
        songDetailVC.songItem = songsList[index]
        
        return songDetailVC
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
    }

    private func configureUI() {
        
        self.songName.text = self.songItem?.songTitle
        
        guard let songUrl = self.songItem?.songThumbnailLink else {
            return
        }
        
        ImageDownloader.fetchSongImage(fromURL: songUrl) { image in
            performOnMain {
                if let image = image {
                    self.songImageView.image = image
                } else {
                    self.songImageView.image = UIImage(named: "")
                }
            }
        }
    }
}

extension SongsDetailViewController {
    
    @IBAction func previousSong(_ sender: Any) {
        
    }
    
    @IBAction func nextSong(_ sender: Any) {
        
    }
    
    
    @IBAction func playSong(_ sender: Any) {
        guard let songURL = self.songItem?.songLink else { return }
       
        do {
            try self.musicPlayer = MusicPlayer(contentsOfURL: songURL)
        } catch  let error  {
            print(error.localizedDescription)
        }
        self.musicPlayer?.play()
    }
    
    @IBAction func repeatSong(_ sender: Any) {
        
    }
    
    @IBAction func shuffleSong(_ sender: Any) {
        
        
    }
    
}
