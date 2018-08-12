//
//  Array+Addition.swift
//  SoundCast
//
//  Created by Dhananjay Kumar Dubey on 11/08/18.
//  Copyright © 2018 Dhananjay Kumar Dubey. All rights reserved.
//

import Foundation

extension Array {
    
    func randomIndex(excluding: Index) -> Index {
        return Int(arc4random_uniform(UInt32(self.count)))
    }
}
