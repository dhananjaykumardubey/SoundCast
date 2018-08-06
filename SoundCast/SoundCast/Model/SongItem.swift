//
//  SongItem.swift
//  SoundCast
//
//  Created by Dhananjay Kumar Dubey on 07/08/18.
//  Copyright © 2018 Dhananjay Kumar Dubey. All rights reserved.
//

import Foundation

struct SongItem {
    
    private static let idKey = "id"
    private static let titleKey = "title"
    private static let songUrlKey = "link"
    private static let thumbnailKey = "thumbnail"
    
    
    let songId: Int?
    let songTitle: String?
    let songLink: String?
    let songThumbnailLink: String?
    
    init(withSongs songData: [String: Any]) {
        
        let selfType = type(of: self)
        
        self.songId = songData[selfType.idKey] as? Int
        self.songTitle = songData[selfType.titleKey] as? String
        self.songLink = songData[selfType.songUrlKey] as? String
        self.songThumbnailLink = songData[selfType.thumbnailKey] as? String
    }
}
