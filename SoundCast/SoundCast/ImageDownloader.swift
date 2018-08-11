//
//  ImageDownloader.swift
//  SoundCast
//
//  Created by Dhananjay Kumar Dubey on 08/08/18.
//  Copyright © 2018 Dhananjay Kumar Dubey. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

class ImageDownloader {
    
    typealias Completion = (UIImage?) -> Void
    
    static func fetchSongImage(fromURL url: String, completion: @escaping Completion) {
        
        Alamofire.request(url).responseImage { response in
            
            if let image = response.result.value {
                
                completion(image)
                
            } else {
                
                completion(nil)
                
            }
        }
    }
}
