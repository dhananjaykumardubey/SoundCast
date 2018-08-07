//
//  SongsListViewController.swift
//  SoundCast
//
//  Created by Dhananjay Kumar Dubey on 07/08/18.
//  Copyright © 2018 Dhananjay Kumar Dubey. All rights reserved.
//

import Foundation
import UIKit

class SongsListViewController: UIViewController {
    
    // MARK: Static constants
    private static let url = "https://www.jasonbase.com/things/zKWW.json"
    private static let rowHeightConstant: CGFloat = 150.0
    
    // MARK: private variables
    private var songsList: [SongItem]?

    // MARK: private outlets
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.estimatedRowHeight = type(of: self).rowHeightConstant
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchSongsList()
    }
    
    private func fetchSongsList() {
        NetworkManager<SongItem>.fetchSongsList(fromURL: type(of: self).url, completion: { [weak self] songs in
            self?.songsList = songs
        })
    }
}

// MARK: UITableViewDelegates and dataSource
extension SongsListViewController: UITableViewDelegate {
    
}

extension SongsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return self.songsList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let songItemCell = tableView.dequeueReusableCell(withIdentifier: SongsListCell.reusableIdentifier) as? SongsListCell else {
            let cell = UITableViewCell(style: .default, reuseIdentifier: SongsListCell.reusableIdentifier)
            return cell
       }

        
        return songItemCell
    }
}
