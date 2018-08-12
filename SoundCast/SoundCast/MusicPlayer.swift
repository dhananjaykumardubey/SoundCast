//
//  MusicPlayer.swift
//  SoundCast
//
//  Created by Dhananjay Kumar Dubey on 09/08/18.
//  Copyright © 2018 Dhananjay Kumar Dubey. All rights reserved.
//

import Foundation
import AVFoundation

/// Music player class which handles the functionality of playing audio
final class MusicPlayer {
    
    // MARK: Private constants
    private static let defaultTimeInterval = CMTime(seconds: 0.05, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
    private let player: AVPlayer
    private(set) var state: State
    private var timeObserverToken: Any?
   
    // MARK: Enums
    /// Enum to maintain the state of music player
    enum State {
        
        /// playing, when audio is in playing mode
        case playing
        
        /// paused, when audio is in paused
        case paused
        
        /// stopped, when audio is stopped, and current time is set to zero
        case stopped
    }
    
    /// Enum to maintain the events of player
    enum Event {
        
        /// When player started playing the song
        case didBegin
        
        /// When player is currently playing the song, which also provides the progress of song of struct type - `Progress`
        case progress(Progress)
        
        /// Player stopped playing song, as the song is completed and notification "playerDidFinishPlaying" is observed
        case didEnd
    }
    
    // MARK: Struct
    
    /// Maintains the progress of audio track
    struct Progress {
        
        /// Indicates the duration of the item
        let duration: TimeInterval
        
        /// Current time of audio track, or elapsed time
        let currentTime: TimeInterval
        
        /// provides the percentage compeletion of audio playback
        let percentCompleted: Double
    }
    
    // MARK: Typealias
    typealias EventCallback = (Event) -> Void
    
    // MARK: public variable
    
    /// Event observer of type EventCallback
    var observer: EventCallback?
    
    // MARK: Initializer
    
    /// Intializes `MusicPlayer` with observer
    init(observer: EventCallback? = nil) {
        self.player = AVPlayer()
        self.state = .stopped
        self.observer = observer
    }
    
    /// Removes the event observer and set the observer to nil in deinitialer
    deinit {
        self.observer = nil
        self.removePeriodicTimeObserver()
    }
    
    // MARK: Public Apis
    
    /**
     Sets the AVPlayerItem with URL and also observes the completion of audio compelition by checking whether audio played till end time. Also observes whether failure occured before reaching the end time of audio.
     
     - parameters:
        - url: song item url, i.e audion track URL which is used to create an AVPlayerItem
     
     - immediate: FLag to check whether song has to be played immediately or not. By default set to FALSE, the caller will have to maintain the state
     
     */
    func set(songURL url: URL, andPlayImmediatly immediate: Bool = false) {
        let item = AVPlayerItem(url: url)
        self.player.replaceCurrentItem(with: item)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.playerDidFinishPlaying),
                                               name: .AVPlayerItemDidPlayToEndTime,
                                               object: item)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.playerDidFinishPlaying),
                                               name: .AVPlayerItemFailedToPlayToEndTime,
                                               object: item)
        immediate ? self.play() : self.stop()
    }
    
    /// Checks whether player is currently playing or not. If not, it plays the audio and starts observing event. Also, state of player is changed to State.playing
    func play() {
        if self.state != .playing {
            self.player.play()
            self.addPeriodicTimeObserver()
            self.state = .playing
        }
    }
    
    /// Pauses the audio player and sets the state of player to .paused
    func pause() {
        self.player.pause()
        self.state = .paused
    }
    
    /// stops the audio player and sets the state of player to .stopped. Also, Removes the event observer
    func stop() {
        self.state = .stopped
        self.removePeriodicTimeObserver()
        self.player.stop()
    }
    
    // MARK: Private Apis
    private func addPeriodicTimeObserver() {
        guard self.timeObserverToken == nil else { return }
        
        let observationHandle: (CMTime) -> Swift.Void = { [weak self] time in
            
            guard let currentItem = self?.player.currentItem else { return }
            let duration = currentItem.duration
            let currentTime = time.timeInterval
            if currentTime == 0 {
                self?.observer?(.didBegin)
            }
            let percentCompleted = currentTime / duration.timeInterval
            let progress = Progress(duration: duration.timeInterval,
                                    currentTime: currentTime,
                                    percentCompleted: percentCompleted)
            self?.observer?(.progress(progress))

        }
        self.timeObserverToken = self.player.addPeriodicTimeObserver(forInterval: type(of: self).defaultTimeInterval,
                                                                     queue: DispatchQueue.main,
                                                                     using: observationHandle)
    }
    
    private func removePeriodicTimeObserver() {
        if let token = self.timeObserverToken {
            self.player.removeTimeObserver(token)
            self.timeObserverToken = nil
        }
    }
    
    @objc private func playerDidFinishPlaying() {
        self.stop()
        self.observer?(.didEnd)
    }
}
