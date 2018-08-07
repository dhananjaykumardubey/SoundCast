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
    private let songThumbnailLink: String?
    
    let songId: Int?
    let songTitle: String?
    let songLink: String?
    
    // MARK: Variable
    var songImageData: Data?
    
    // MARK: Initializer
    init(withSongData songData: [String: Any]) {
        
        let selfType = type(of: self)
        
        self.songId = songData[selfType.idKey] as? Int
        self.songTitle = songData[selfType.titleKey] as? String
        self.songLink = songData[selfType.songUrlKey] as? String
        self.songThumbnailLink = songData[selfType.thumbnailKey] as? String
    }
    
    // MARK: Private methods.
    private func fetchSongImageData(fromURL urlString: String?) {
        
        guard let urlString = urlString else {
            return
        }
        
        ImageDownloader.fetchSongImage(fromURL: urlString) { imageData in
            self.songImageData = imageData
        }
        
    }
}
