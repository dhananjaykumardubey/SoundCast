
//  SongsListCell.swift
//  SoundCast
//
//  Created by Dhananjay Kumar Dubey on 07/08/18.
//  Copyright © 2018 Dhananjay Kumar Dubey. All rights reserved.
//

import UIKit
import Kingfisher

class SongsListCell: UITableViewCell {
    
    //MARK: static constants
    
    /// Cell reusable identifier
    static let reusableIdentifier = "SongsListCellIdentifier"
    
    /// Cell nib name
    static let nibName = "SongListCell"
    
    //MARK: Private outlets
    @IBOutlet private weak var songImageView: UIImageView!
    @IBOutlet private weak var songTitle: UILabel!
    

    /**
     Configures cell with song details
     - parameter songItem: song item of type `SongItem`
     */
    func configureSongItem(withSong songItem: SongItem) {
        
        self.songTitle.text = songItem.songTitle
        
        guard let imageURL = songItem.songThumbnailLink else { return }
        self.songImageView?.kf.setImage(with: imageURL)
        
    }
    
}
