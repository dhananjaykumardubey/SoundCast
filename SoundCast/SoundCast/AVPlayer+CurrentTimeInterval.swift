//
//  AVPlayer+CurrentTimeInterval.swift
//  SoundCast
//
//  Created by Dhananjay Kumar Dubey on 12/08/18.
//  Copyright © 2018 Dhananjay Kumar Dubey. All rights reserved.
//

import AVFoundation

/// Extension of AVPlayer
extension AVPlayer {
    
    /// Provides the current time interval from current time of audion
    var currentTimeInterval: TimeInterval {
        return self.currentTime().timeInterval
    }
    
    /// Pause the current audio playing and seek the current time to zero to give it a functionality of stop of audio
    func stop() {
        self.pause()
        self.seek(to: CMTime(seconds: 0, preferredTimescale: self.currentTime().timescale))
    }
}
