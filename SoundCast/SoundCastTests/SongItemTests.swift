//
//  SongItemTests.swift
//  SoundCastTests
//
//  Created by Dhananjay Kumar Dubey on 12/08/18.
//  Copyright © 2018 Dhananjay Kumar Dubey. All rights reserved.
//

import XCTest
@testable import SoundCast

class SongItemTests: XCTestCase {
    
   private static let songURL = URL(string: "https://static.talview.com/hiring/android/soundcast/mp3/fast-and-furious.mp3")
    
   private static let songImageURL = URL(string: "https://static.talview.com/hiring/android/soundcast/thumbs/fast-and-furious.jpg")
    
    func testIntializer() {
        let selfType = type(of: self)
        
        let stubbedData = ["id": 1,
                                          "title": "Test title",
                                          "link":"https://static.talview.com/hiring/android/soundcast/mp3/fast-and-furious.mp3",
                                          "thumbnail":"https://static.talview.com/hiring/android/soundcast/thumbs/fast-and-furious.jpg"
            ] as [String : Any]
        
        let songItem = SongItem(withSongData: stubbedData)
        XCTAssertEqual(songItem.songId, 1)
        XCTAssertEqual(songItem.songTitle, "Test title")
        XCTAssertEqual(songItem.songLink, selfType.songURL)
        XCTAssertEqual(songItem.songThumbnailLink, selfType.songImageURL)
        
    }
    
    func testIntializerForNoSongAndImageURL() {
        let stubbedData = ["id": 1,
                           "title": "Test title"
            ] as [String : Any]
        let songItem = SongItem(withSongData: stubbedData)
        XCTAssertEqual(songItem.songId, 1)
        XCTAssertEqual(songItem.songTitle, "Test title")
        XCTAssertNil(songItem.songThumbnailLink)
        XCTAssertNil(songItem.songLink)
    }
    
    func testEmptyIntializer() {
        let songItem = SongItem(withSongData: [:])
        XCTAssertNil(songItem.songId)
        XCTAssertNil(songItem.songTitle)
        XCTAssertNil(songItem.songThumbnailLink)
        XCTAssertNil(songItem.songLink)
    }
    
}
