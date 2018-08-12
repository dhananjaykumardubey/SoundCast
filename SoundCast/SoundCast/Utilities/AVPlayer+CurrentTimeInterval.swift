//
//  AVPlayer+CurrentTimeInterval.swift
//  SoundCast
//
//  Created by Dhananjay Kumar Dubey on 12/08/18.
//  Copyright © 2018 Dhananjay Kumar Dubey. All rights reserved.
//

import AVFoundation

extension AVPlayer {
    var currentTimeInterval: TimeInterval {
        return self.currentTime().timeInterval
    }
    
    func stop() {
        self.pause()
        self.seek(to: CMTime(seconds: 0, preferredTimescale: self.currentTime().timescale))
    }
}
