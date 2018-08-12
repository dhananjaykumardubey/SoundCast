//
//  MusicPlayer.swift
//  SoundCast
//
//  Created by Dhananjay Kumar Dubey on 09/08/18.
//  Copyright © 2018 Dhananjay Kumar Dubey. All rights reserved.
//

import Foundation
import AVFoundation

final class MusicPlayer {
    private static let defaultTimeInterval = CMTime(seconds: 0.05, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
    enum State {
        case playing
        case paused
        case stopped
    }
    
    struct Progress {
        let duration: TimeInterval
        let currentTime: TimeInterval
        let percentCompleted: Double
    }
    enum Event {
        case didBegin
        case progress(Progress)
        case didEnd
    }
    
    typealias EventCallback = (Event) -> Void
    
    private let player: AVPlayer
    private(set) var state: State
    private var timeObserverToken: Any?
    
    var observer: EventCallback?
    
    init(observer: EventCallback? = nil) {
        self.player = AVPlayer()
        self.state = .stopped
        self.observer = observer
    }
    
    deinit {
        self.observer = nil
        self.removePeriodicTimeObserver()
    }
    
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
    
    func play() {
        if self.state != .playing {
            self.player.play()
            self.addPeriodicTimeObserver()
            self.state = .playing
        }
    }
    
    func pause() {
        self.player.pause()
        self.state = .paused
    }
    
    func stop() {
        self.state = .stopped
        self.removePeriodicTimeObserver()
        self.player.stop()
    }
    
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
