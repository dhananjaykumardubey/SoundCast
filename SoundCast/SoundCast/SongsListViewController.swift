//
//  SongsListViewController.swift
//  SoundCast
//
//  Created by Dhananjay Kumar Dubey on 07/08/18.
//  Copyright © 2018 Dhananjay Kumar Dubey. All rights reserved.
//

import Foundation
import UIKit

final class SongsListViewController: UIViewController {
    
    // MARK: Static constants
    private static let rowHeightConstant: CGFloat = 100.0
    
    // MARK: private variables
    private var songsList: [SongItem]?

    // MARK: private outlets
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.estimatedRowHeight = type(of: self).rowHeightConstant
            self.tableView.rowHeight = UITableViewAutomaticDimension
            self.tableView.register(UINib(nibName: SongsListCell.nibName, bundle: nil), forCellReuseIdentifier: SongsListCell.reusableIdentifier)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchSongsList()
    }
    
    private func fetchSongsList() {
        
        let handle: NetworkManager<SongItem>.Completion = { [weak self] songs in
            self?.songsList = songs
            performOnMain {
                self?.tableView.reloadData()
            }
        }
        
        NetworkManager.fetchSongsList(completion: handle)
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
        
        guard let songItemCell = tableView.dequeueReusableCell(withIdentifier: SongsListCell.reusableIdentifier) as? SongsListCell, let songsList = self.songsList else {
            let cell = UITableViewCell(style: .default, reuseIdentifier: SongsListCell.reusableIdentifier)
            return cell
       }
        
        songItemCell.configureSongItem(withSong: songsList[indexPath.row])
        return songItemCell
    }
}
