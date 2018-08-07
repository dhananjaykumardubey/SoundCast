//
//  ImageDownloader.swift
//  SoundCast
//
//  Created by Dhananjay Kumar Dubey on 08/08/18.
//  Copyright © 2018 Dhananjay Kumar Dubey. All rights reserved.
//

import Foundation
import Alamofire

class ImageDownloader {
    
    typealias Completion = (Data?) -> Void
    
    static func fetchSongImage(fromURL url: String, completion: @escaping Completion) {
        
        Alamofire.request(url).responseData { response in
            
            guard response.error != nil,
                let responseData = response.data else {
               return completion(nil)
            }
            
            completion(responseData)
        }
    }
}
