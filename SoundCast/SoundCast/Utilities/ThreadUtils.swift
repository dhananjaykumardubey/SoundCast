//
//  ThreadUtils.swift
//  SoundCast
//
//  Created by Dhananjay Kumar Dubey on 08/08/18.
//  Copyright © 2018 Dhananjay Kumar Dubey. All rights reserved.
//

import Foundation

/// Executes provided closure on main thred
///
/// - Parameter workItem: Work item closure to be executed
func performOnMain(_ workItem: () -> Void) {
    if Thread.isMainThread {
        workItem()
    } else {
        DispatchQueue.main.sync {
            workItem()
        }
    }
}
