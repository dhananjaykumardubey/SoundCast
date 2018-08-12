
//  SongsListCell.swift
//  SoundCast
//
//  Created by Dhananjay Kumar Dubey on 07/08/18.
//  Copyright © 2018 Dhananjay Kumar Dubey. All rights reserved.
//

import UIKit
import Kingfisher

class SongsListCell: UITableViewCell {
    
    static let reusableIdentifier = "SongsListCellIdentifier"
    static let nibName = "SongListCell"
    
    @IBOutlet private weak var songImageView: UIImageView!
    @IBOutlet private weak var songTitle: UILabel!
    

    func configureSongItem(withSong songItem: SongItem) {
        
        self.songTitle.text = songItem.songTitle
        
        guard let imageURL = songItem.songThumbnailLink else { return }
        self.songImageView?.kf.setImage(with: imageURL)
        
    }
    
}
