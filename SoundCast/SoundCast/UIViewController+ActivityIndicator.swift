//
//  UIViewController+ActivityIndicator.swift
//  SoundCast
//
//  Created by Dhananjay Kumar Dubey on 12/08/18.
//  Copyright © 2018 Dhananjay Kumar Dubey. All rights reserved.
//

import UIKit
extension UIViewController {
    
    func showActivity(withTitle title: String?, andMessage message: String?) {
        ActivityIndicatorProvider.shared.showActivity(onView: self.view, withTitle: title, andMessage: message)
    }
    
    func hideActivity() {
        ActivityIndicatorProvider.shared.hideActivity()
    }
}

