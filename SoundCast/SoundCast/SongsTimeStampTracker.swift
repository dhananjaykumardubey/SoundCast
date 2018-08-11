//
//  SongsTimeStampTracker.swift
//  SoundCast
//
//  Created by Dhananjay Kumar Dubey on 09/08/18.
//  Copyright © 2018 Dhananjay Kumar Dubey. All rights reserved.
//

import Foundation

protocol SongPlayerDelegate: class {
    
    func musicPlayer( _ musicPlayer: MusicPlayer, didUpdateTimeStamp timeStamp: SongsTimeStamp)
    func musicPlayerDidBeginPlaying(_ musicPlayer: MusicPlayer, atTimeStamp: SongsTimeStamp)
    func musicPlayerDidPaused(_ musicPlayer: MusicPlayer, atTimeStamp: SongsTimeStamp)
    func musicPlayerDidStopped(_ musicPlayer: MusicPlayer, atTimeStamp: SongsTimeStamp)
}

class SongsTimeStamp {
    
    private let timeInterval: Int
    
    var seconds: Int {
        get {
            return self.timeInterval % 60
        }
    }
    
    var minutes: Int {
        get {
            return (self.timeInterval / 60) % 60
        }
    }
    
    var formattedTimeStampString: String {
        return String(format: "%02i:%02i", self.minutes, self.seconds)
    }
    
    init(seconds: TimeInterval) {
        self.timeInterval = Int(seconds)
    }
}
