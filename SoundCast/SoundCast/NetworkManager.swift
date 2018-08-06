//
//  NetworkManager.swift
//  SoundCast
//
//  Created by Dhananjay Kumar Dubey on 06/08/18.
//  Copyright © 2018 Dhananjay Kumar Dubey. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
    
    private static let songsKey = "songs"
    
    typealias Completion = ([[String: Any]]?) -> Void
    
    static func fetchSongsList(completion: @escaping Completion) {
        
        guard let urlString = URL(string: "https://www.jasonbase.com/things/zKWW.json") else {
            return
        }
        
        Alamofire.request(urlString).responseJSON { response in
            if let result = response.result.value as? [String: Any],
                let responseData = result[self.songsKey] as? [[String: Any]] {
                completion(responseData)
            } else {
                completion(nil)
            }
        }
    }
}
