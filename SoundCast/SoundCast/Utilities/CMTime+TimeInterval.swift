//
//  CMTime+TimeInterval.swift
//  SoundCast
//
//  Created by Dhananjay Kumar Dubey on 12/08/18.
//  Copyright © 2018 Dhananjay Kumar Dubey. All rights reserved.
//

import AVFoundation

extension CMTime {
    var timeInterval: TimeInterval {
        
        return Double(CMTimeGetSeconds(self))
    }
}
