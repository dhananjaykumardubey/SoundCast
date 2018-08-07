//
//  SongsListCell.swift
//  SoundCast
//
//  Created by Dhananjay Kumar Dubey on 07/08/18.
//  Copyright © 2018 Dhananjay Kumar Dubey. All rights reserved.
//

import Foundation
import UIKit

class SongsListCell: UITableViewCell {
    
    static let reusableIdentifier = "SongsListCellIdentifier"
    
    @IBOutlet private weak var songImageView: UIImageView! {
        didSet {
            self.songImageView.layer.cornerRadius = 30.0
        }
    }
    
    @IBOutlet private weak var songTitle: UILabel!
    
    
}
