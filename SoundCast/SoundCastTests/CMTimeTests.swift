//
//  CMTimeTests.swift
//  SoundCastTests
//
//  Created by Dhananjay Kumar Dubey on 12/08/18.
//  Copyright © 2018 Dhananjay Kumar Dubey. All rights reserved.
//

import XCTest
import AVFoundation
@testable import SoundCast

class CMTimeTests: XCTestCase {
    
    func testTimeInterval() {
       let time = CMTimeMake(1800, 10)
        XCTAssertEqual(time.timeInterval, 180.0)
    }
    
}
