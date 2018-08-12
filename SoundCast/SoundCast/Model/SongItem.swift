//
//  SongItem.swift
//  SoundCast
//
//  Created by Dhananjay Kumar Dubey on 07/08/18.
//  Copyright © 2018 Dhananjay Kumar Dubey. All rights reserved.
//

import Foundation

protocol SongItemInitializer {
    init(withSongData: [String: Any])
}

struct SongItem: SongItemInitializer {
    
    // MARK: private static constants
    private static let idKey = "id"
    private static let titleKey = "title"
    private static let songUrlKey = "link"
    private static let thumbnailKey = "thumbnail"
    
    // MARK:  Constants
    let songThumbnailLink: URL?
    let songId: Int?
    let songTitle: String?
    let songLink: URL?

    init(withSongData songData: [String: Any]) {
        
        let selfType = type(of: self)
        
        self.songId = songData[selfType.idKey] as? Int
        self.songTitle = songData[selfType.titleKey] as? String
        let songUrl = songData[selfType.songUrlKey] as? String
        self.songLink = URL(string: songUrl ?? "")
        if let songThumbnailLink = songData[selfType.thumbnailKey] as? String {
            self.songThumbnailLink = URL(string: songThumbnailLink)
        } else {
            self.songThumbnailLink = nil
        }
    }
}
