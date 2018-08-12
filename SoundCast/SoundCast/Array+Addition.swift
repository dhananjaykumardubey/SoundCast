//
//  Array+Addition.swift
//  SoundCast
//
//  Created by Dhananjay Kumar Dubey on 11/08/18.
//  Copyright © 2018 Dhananjay Kumar Dubey. All rights reserved.
//

import Foundation

/// Extension on Array
extension Array {
    
    /**
     Provides random index from array
     - returns: Random index generated via `arc4random_uniform`
     */
    func randomIndex() -> Index {
        return Int(arc4random_uniform(UInt32(self.count)))
    }
}
