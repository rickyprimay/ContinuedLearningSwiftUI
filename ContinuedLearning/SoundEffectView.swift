//
//  SoundEffectView.swift
//  ContinuedLearning
//
//  Created by Ricky Primayuda Putra on 09/12/24.
//

import SwiftUI
import AVKit

class SoundManager: ObservableObject {
    
    var player: AVAudioPlayer?
    
    enum SoundOption: String {
        case tada
        case badum
    }
    
    func playSound(sound: SoundOption) {
        
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print("errpr playing sound. \(error.localizedDescription)")
        }
       
    }
    
}

struct SoundEffectView: View {
    
    @StateObject var sm = SoundManager()
    
    var body: some View {
        VStack(spacing: 20) {
            Button{
                sm.playSound(sound: .tada)
            } label : {
                Text("Play Sound 1")
            }
            Button{
                sm.playSound(sound: .badum)
            } label : {
                Text("Play Sound 2")
            }
        }
    }
}

#Preview {
    SoundEffectView()
}
