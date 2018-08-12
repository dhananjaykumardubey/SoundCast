//
//  Songs+Storyboards.swift
//  RedPandaAssignment
//
//  Created by Dhananjay Kumar Dubey on 08/08/18.
//  Copyright © 2018 Dhananjay Kumar Dubey. All rights reserved.
//

import UIKit

/// provides storyboard name
enum Storyboard: String {
    
    case main = "Main"
    
    var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: nil)
    }
}
