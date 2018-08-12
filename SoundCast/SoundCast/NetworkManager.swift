//
//  NetworkManager.swift
//  SoundCast
//
//  Created by Dhananjay Kumar Dubey on 06/08/18.
//  Copyright © 2018 Dhananjay Kumar Dubey. All rights reserved.
//

import Foundation
import Alamofire

private enum Constant {
    static let songsKey = "songs"
}

class NetworkManager<T: SongItemInitializer> {
    
    typealias Completion = ([T]?) -> Void
    
    static func fetchSongsList(fromURL url: String = "https://www.jasonbase.com/things/zKWW.json",
                               completion: @escaping Completion) {

        Alamofire.request(url).responseJSON { response in
            if let result = response.result.value as? [String: Any],
                let responseData = result[Constant.songsKey] as? [[String: Any]] {
                
                completion(self.parse(withSongsData: responseData))
                
            } else {
                
                completion(nil)
                
            }
        }
    }
    
    private static func parse(withSongsData responseData: [[String: Any]]) -> [T] {
        return responseData.map { T(withSongData: $0) }
    }
}
