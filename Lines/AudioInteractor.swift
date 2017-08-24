//
//  AudioInteractor.swift
//  Lines
//
//  Created by Fraser King on 2017-08-24.
//  Copyright © 2017 Fraser King. All rights reserved.
//

import Foundation
import AVFoundation

struct AudioInteractor {
    private init() {}
    
    fileprivate static var musicPlayer: AVAudioPlayer?
    fileprivate static var successPlayer: AVAudioPlayer?

    static func playSuccess() {
        guard let url = Bundle.main.url(forResource: "success", withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            successPlayer = try AVAudioPlayer(contentsOf: url)
            guard let player = successPlayer else { return }
            
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    static func playBackgroundMusic() {
        guard let url = Bundle.main.url(forResource: "background", withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            musicPlayer = try AVAudioPlayer(contentsOf: url)
            musicPlayer?.numberOfLoops = -1
            guard let player = musicPlayer else { return }
            
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
}
