//
//  SongService.swift
//  SoundCast
//
//  Created by Dhananjay Kumar Dubey on 12/08/18.
//  Copyright © 2018 Dhananjay Kumar Dubey. All rights reserved.
//

import Foundation
import Alamofire

private let songsKey = "songs"

/// Enum to handle different kind of errors.
enum SongServiceError: Error {
    /// Throws error when request URL is incorrect
    case invalidRequestURL
    
    /// Throws error when response is not recieved
    case invalidResponse
    
    /// Provides error title
    var errorTitle: String {
        return "Oops!"
    }
    
    /// Provides error message for different error type
    var errorMessage: String {
        switch self {
        case .invalidRequestURL:
            return "Please check the request URL. Try Again"
        case .invalidResponse:
            return "Something went terribly wrong. Please try again later."
        }
    }
}

/// Service layer which calls network manager for API call. This is a intermediate layer between network manager and view controller
struct SongService {
    
    // MARK: Type alias for completion handlere of request
    typealias CompletionHandler = (Alamofire.Result<[SongItem]>) -> Void
    
    // MARK: Private constant
    private let url: URL?
    
    //MARK: Initializer
    
    /**
     Intializes SongService with request URL
     
     - parameter url: reuqest URL of type URL? , Default request url = "https://www.jasonbase.com/things/zKWW.json"
     */
    init(url: URL? = URL(string: "https://www.jasonbase.com/things/zKWW.json")) {
        self.url = url
    }
    
    /**
     Request to fetch songs using network manager
     
     - parameters:
         - manager: Instance of type `NetworkManager`
         - handle: Completion handler callback once response is recieved, is type  of `Result<[SongItem]>`, can be success or failure
     */
    func fetchSongs(using manager: NetworkManager.Type, then handle: @escaping CompletionHandler) {
        guard let url = self.url else {
            handle(.failure(SongServiceError.invalidRequestURL))
            return
        }
        manager.request(with: url) { result in
            do {
                switch result {
                case.success(let json):
                    let items = try self.parse(withSongsData: json)
                    handle(.success(items))
                case .failure(let error):
                    handle(.failure(error))
                }
            } catch {
                handle(.failure(error))
            }
        }
    }
    
    private func parse(withSongsData responseData: Any) throws -> [SongItem] {
        guard
            let jsonResponse = responseData as? [String: Any],
            let songs = jsonResponse[songsKey] as? [[String: Any]]
            else { throw SongServiceError.invalidResponse }
        
        return songs.compactMap(SongItem.init(withSongData:))
    }
}
