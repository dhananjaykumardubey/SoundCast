//
//  SongItem.swift
//  SoundCast
//
//  Created by Dhananjay Kumar Dubey on 07/08/18.
//  Copyright © 2018 Dhananjay Kumar Dubey. All rights reserved.
//

import Foundation

struct SongItem {
    
    // MARK: private static constants
    private static let idKey = "id"
    private static let titleKey = "title"
    private static let songUrlKey = "link"
    private static let thumbnailKey = "thumbnail"
    
    // MARK:  Constants
    
    /// Song image url 
    let songThumbnailLink: URL?
    
    /// Song Id
    let songId: Int?
    
    /// Song title
    let songTitle: String?
    
    /// Song URL
    let songLink: URL?

    // MARK: Intializer
    
    /**
     Initializes song item
     - parameter songData: Json data fetched from API
     */
    init(withSongData songData: [String: Any]) {
        
        let selfType = type(of: self)
        
        self.songId = songData[selfType.idKey] as? Int
        self.songTitle = songData[selfType.titleKey] as? String
        if let songUrl = songData[selfType.songUrlKey] as? String {
            self.songLink = URL(string: songUrl)
        } else {
            self.songLink = nil
        }
        
        if let songThumbnailLink = songData[selfType.thumbnailKey] as? String {
            self.songThumbnailLink = URL(string: songThumbnailLink)
        } else {
            self.songThumbnailLink = nil
        }
    }
}
