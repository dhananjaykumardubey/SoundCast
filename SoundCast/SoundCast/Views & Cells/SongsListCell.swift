
//  SongsListCell.swift
//  SoundCast
//
//  Created by Dhananjay Kumar Dubey on 07/08/18.
//  Copyright © 2018 Dhananjay Kumar Dubey. All rights reserved.
//

import Foundation
import UIKit

class SongsListCell: UITableViewCell {
    
    static let reusableIdentifier = "SongsListCellIdentifier"
    static let nibName = "SongListCell"
    
    @IBOutlet private weak var songImageView: UIImageView!
    @IBOutlet private weak var songTitle: UILabel!
    

    func configureSongItem(withSong songItem: SongItem) {
        
        self.songTitle.text = songItem.songTitle
        
        guard let songUrl = songItem.songThumbnailLink else {
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
