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
    
    typealias Completion = (Alamofire.Result<Any>) -> Void
    
    static func request(with url: URL, completion: @escaping Completion) {

        Alamofire.request(url).responseJSON { response in
            
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
