//
//  MusicPlayer.swift
//  SoundCast
//
//  Created by Dhananjay Kumar Dubey on 09/08/18.
//  Copyright © 2018 Dhananjay Kumar Dubey. All rights reserved.
//

import Foundation
import AVFoundation

class MusicPlayer: NSObject {
    
    private let player: AVAudioPlayer
    private var updateTimer = Timer()
    
    weak var delegate: SongPlayerDelegate?
    
    
    init(contentsOfURL url: URL) throws {
        do {
            try self.player = AVAudioPlayer(contentsOf: url)
            super.init()
            self.player.delegate = self
            
        } catch let error {
            player = AVAudioPlayer()
            super.init()
            throw error
        }
    }
    
    @objc private func update() {
        self.delegate?.musicPlayer(self, didUpdateTimeStamp: SongsTimeStamp(seconds: self.player.currentTime))
    }
    
    func play() {
        let timeStamp = SongsTimeStamp(seconds: self.player.currentTime)
        if !self.player.isPlaying {
            self.player.play()
        }
        self.delegate?.musicPlayerDidBeginPlaying(self, atTimeStamp: timeStamp)
        
        self.updateTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
        self.updateTimer.fire()
        
    }
    
    func pause() {
        let timeStamp = SongsTimeStamp(seconds: self.player.currentTime)
        self.player.pause()
        self.delegate?.musicPlayerDidPaused(self, atTimeStamp: timeStamp)
        self.updateTimer.invalidate()
        self.update()
    }
    
    func stop() {
        let timeStamp = SongsTimeStamp(seconds: self.player.currentTime)
        self.player.stop()
        self.player.currentTime = 0
        self.delegate?.musicPlayerDidStopped(self, atTimeStamp: timeStamp)
        self.updateTimer.invalidate()
        self.update()
    }
    
    func shuffle() {
        
    }
    
    func repeatSong() {
        
    }
}

extension MusicPlayer: AVAudioPlayerDelegate {
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            self.updateTimer.invalidate()
            self.update()
            
            // continue to next song if there is any
        }
    }
}
