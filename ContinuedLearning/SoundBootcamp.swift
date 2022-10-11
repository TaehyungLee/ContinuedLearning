//
//  SoundBootcamp.swift
//  ContinuedLearning
//
//  Created by Taehyung Lee on 2022/10/10.
//

import SwiftUI
import AVKit

class SoundManager {
    
    // singleton
    static let instance = SoundManager()
    
    var player:AVAudioPlayer?
    
    enum SoundOption:String {
        case ringing = "ringing-small-bell-sound-effect"
        case morning = "early-morning-sounds"
    }
    
    func playSound(option:SoundOption) {
        
//        guard let url = URL(string: "") else { return }
        guard let url = Bundle.main.url(forResource: option.rawValue, withExtension: ".mp3") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print("Error playing sound. \(error.localizedDescription)")
        }
        
    }
    
}

struct SoundBootcamp: View {
    
    
    var body: some View {
        VStack(spacing: 40) {
            Button("Play sound 1") {
                SoundManager.instance.playSound(option: .morning)
            }
            Button("Play sound 2") {
                SoundManager.instance.playSound(option: .ringing)
            }
        }
    }
}

struct SoundBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        SoundBootcamp()
    }
}
