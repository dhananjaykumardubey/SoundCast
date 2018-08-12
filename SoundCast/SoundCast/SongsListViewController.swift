//
//  SongsListViewController.swift
//  SoundCast
//
//  Created by Dhananjay Kumar Dubey on 07/08/18.
//  Copyright © 2018 Dhananjay Kumar Dubey. All rights reserved.
//

import Foundation
import UIKit

/// This class is used to display the list of songs downloaded from API
final class SongsListViewController: UIViewController {
    
    // MARK: Static constants
    private static let rowHeightConstant: CGFloat = 100.0
    
    // MARK: private variables
    private var songsList: [SongItem]?
    private let service = SongService()
    
    // MARK: private outlets
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            guard let image = UIImage(named: MusicResource.listBackgroundImage) else {
                return
            }
            self.tableView.backgroundColor = UIColor(patternImage: image)
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.estimatedRowHeight = type(of: self).rowHeightConstant
            self.tableView.rowHeight = UITableViewAutomaticDimension
            self.tableView.register(UINib(nibName: SongsListCell.nibName, bundle: nil), forCellReuseIdentifier: SongsListCell.reusableIdentifier)
        }
    }
    
    // MARK: functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchSongsList()
    }
    
    private func fetchSongsList() {
        let handle: SongService.CompletionHandler = { [weak self] response in
            switch response {
            case .success(let songs):
                self?.songsList = songs
                performOnMain {
                    self?.tableView.reloadData()
                }
                
            case .failure(let error):
                self?.showError(error)
            }
            
        }
        
        self.service.fetchSongs(using: NetworkManager.self, then: handle)
    }
}

// MARK: UITableViewDelegates
extension SongsListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let songsList = self.songsList else { return }
        
        let songsDetailVC = SongsDetailViewController.instantiateSongsDetail(withSongsList: songsList, forIndex: indexPath.row)
        
        self.navigationController?.pushViewController(songsDetailVC, animated: true)
    }
}

// MARK: UITableViewDataSource
extension SongsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.songsList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SongsListCell.reusableIdentifier,
                                                 for: indexPath)
        
        if let songItemCell = cell as? SongsListCell, let songsList = self.songsList  {
            songItemCell.configureSongItem(withSong: songsList[indexPath.row])
        }
        return cell
    }
}

// MARK: Alert handler
extension SongsListViewController {
    
    static private let okButtonTitle = "OK"
    
    private func showError(_ error: Error) {
        
        let title: String
        let message: String
        
        let selfType = type(of: self)
        
        if let error = error as? SongServiceError {
            title = error.errorTitle
            message = error.errorMessage
        } else {
            title = "\((error as NSError).code)"
            message = error.localizedDescription
        }
        
        let alertViewController = UIAlertController(title: title,
                                                    message: message,
                                                    preferredStyle: .alert)
        
        alertViewController.addAction(UIAlertAction(title: selfType.okButtonTitle,
                                                    style: .cancel,
                                                    handler: nil))
        self.present(alertViewController, animated: true, completion: nil)
    }
}
