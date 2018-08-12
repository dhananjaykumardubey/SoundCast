//
//  CMTime+TimeInterval.swift
//  SoundCast
//
//  Created by Dhananjay Kumar Dubey on 12/08/18.
//  Copyright © 2018 Dhananjay Kumar Dubey. All rights reserved.
//

import AVFoundation

/// Extension of CMTime
extension CMTime {
    
    /// Returns time interval after converting the CMTime value into seconds
    var timeInterval: TimeInterval {
        
        return Double(CMTimeGetSeconds(self))
    }
}
