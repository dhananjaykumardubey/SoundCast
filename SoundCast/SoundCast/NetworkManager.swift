//
//  NetworkManager.swift
//  SoundCast
//
//  Created by Dhananjay Kumar Dubey on 06/08/18.
//  Copyright © 2018 Dhananjay Kumar Dubey. All rights reserved.
//

import Foundation
import Alamofire

/// This is a network layer which communicates with Alamofire , creates a request and provides response in form of JSON.
class NetworkManager {
    
    typealias Completion = (Alamofire.Result<Any>) -> Void
    
    /**
     Creates a request with URL, and provides response in form of `Result`
     
     - parameters:
        - url: request URL
        - completion: callback once response is received can be success or failure
     */
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
