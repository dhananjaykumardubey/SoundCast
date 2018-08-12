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

enum SongServiceError: Error {
    case invalidRequestURL
    case invalidResponse
}

struct SongService {
    
    typealias CompletionHandler = (Alamofire.Result<[SongItem]>) -> Void
    
    let url: URL?
    init(url: URL? = URL(string: "https://www.jasonbase.com/things/zKWW.json")) {
        self.url = url
    }
    
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
